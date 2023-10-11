//+------------------------------------------------------------------+
//|                                                      Sofia 2.mq4 |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Software Corp."
#property link      "https://tinyurl.com/eaburequest"
#property version   "5.00"
#property strict

//Parameters
enum pos
  {
   AA = 0, // Buy & Sell
   BB = 1, // Buy Only
   CC = 2, // Sell Only

  };
//--- input parameters
extern pos Pos_Mode = AA; // Positions Mode
extern double Lots = 0.01; //initial Lot
extern double TakeProfit = 100.0;// take profit in pips
extern double StopLoss = 100;// stop loss in pips
extern bool Hedging = false; // enable/disable hedging
extern int MagicNumber = 567456;
extern string EA_Name = "[https://t.me/SyariefAzman] ";
extern bool autoCompound = true;
extern double initialCapital = 1000;

double BuySL, SellSL, buylot, selllot, BuyTP, SellTP;
double sprice, bprice;
int LotDigits; // initialized in OnInit
int SellTicket[];
int BuyTicket[];
bool allowsell, allowbuy;
double pips;
int current = 0; // current bar index, used by Cross Up, Cross Down and many other blocks
double minSLTP;
double Spread;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---}
   buylot = Lots;
   selllot = Lots;
   allowbuy = true;
   allowsell = true;
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   OnEveryNewBar();
  }
//+------------------------------------------------------------------+
//|On every new bar|
//+------------------------------------------------------------------+
datetime BarTime;
void OnEveryNewBar()
  {
   if(BarTime < Time[0])
     {
      // we have a new bar opened
      BarTime = Time[0]; // keep the new bar open time
      main();
     }
  }
//+------------------------------------------------------------------+
//|Main operation|
//+------------------------------------------------------------------+
void main()
  {
   double ticksize = MarketInfo(Symbol(), MODE_TICKSIZE);
   if(ticksize == 0.00001 || ticksize == 0.001)
     {
      pips = ticksize * 10;
      minSLTP = (MarketInfo(Symbol(), MODE_STOPLEVEL)) / 10;
      Spread = MarketInfo(Symbol(), MODE_SPREAD) / 10;
     }
   else
     {
      pips = ticksize;
      minSLTP = (MarketInfo(Symbol(), MODE_STOPLEVEL));
      Spread = MarketInfo(Symbol(), MODE_SPREAD);
     }
// initialize LotDigits
   double LotStep = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);
   if(NormalizeDouble(LotStep, 3) == round(LotStep))
     {
      LotDigits = 0;
     }
   else
      if(NormalizeDouble(10 * LotStep, 3) == round(10 * LotStep))
        {
         LotDigits = 1;
        }
      else
         if(NormalizeDouble(100 * LotStep, 3) == round(100 * LotStep))
           {
            LotDigits = 2;
           }
         else
           {
            LotDigits = 3;
           }
   if(autoCompound == true)
     {
      buylot = Lots / initialCapital * AccountEquity();
      selllot = Lots / initialCapital * AccountEquity();
      FirstPosition();
      allowbuy = true;
      allowsell = true;
     }
   else
     {
      FirstPosition();
      allowbuy = true;
      allowsell = true;
     }
  }
//+------------------------------------------------------------------+
//|here the ea will analyze the chart indicator|
//+------------------------------------------------------------------+
string AnalysisResult()   // OriginJoey
  {
   if(
      (iMA(Symbol(), 0, 5, 0, MODE_LWMA, PRICE_CLOSE, 1) > iMA(Symbol(), 0, 5, 0, MODE_LWMA, PRICE_CLOSE, 2))
      && (iStochastic(Symbol(), 0, 9, 3, 5, MODE_LWMA, 1, MODE_MAIN, 1) > iStochastic(Symbol(), 0, 9, 3, 5, MODE_LWMA, 1, MODE_SIGNAL, 1))
      && (iMACD(Symbol(), 0, 5, 35, 5, PRICE_CLOSE, MODE_MAIN, 1) > iMACD(Symbol(), 0, 5, 35, 5, PRICE_CLOSE, MODE_SIGNAL, 1))
      && (iStochastic(Symbol(), 0, 9, 3, 5, MODE_LWMA, 1, MODE_MAIN, 1) < 20)
   )
     {
      return "Buy";
     }
   if(
      (iMA(Symbol(), 0, 5, 0, MODE_LWMA, PRICE_CLOSE, 1) < iMA(Symbol(), 0, 5, 0, MODE_LWMA, PRICE_CLOSE, 2))
      && (iStochastic(Symbol(), 0, 9, 3, 5, MODE_LWMA, 1, MODE_MAIN, 1) < iStochastic(Symbol(), 0, 9, 3, 5, MODE_LWMA, 1, MODE_SIGNAL, 1))
      && (iMACD(Symbol(), 0, 5, 35, 5, PRICE_CLOSE, MODE_MAIN, 1) < iMACD(Symbol(), 0, 5, 35, 5, PRICE_CLOSE, MODE_SIGNAL, 1))
      && (iStochastic(Symbol(), 0, 9, 3, 5, MODE_LWMA, 1, MODE_MAIN, 1) > 80)
   )
     {
      return "Sell";
     }
   else
     {
      return "no entry";
     }
  }
//+------------------------------------------------------------------+
//|enter positions|
//+------------------------------------------------------------------+
void FirstPosition()
  {
//---First Buy process
   if((Pos_Mode != CC) && (Allow("buy")) && (iRSI(NULL, PERIOD_H1, 14, PRICE_CLOSE, 1) < 70) && (AnalysisResult() == "Buy"))
     {
      if(AccountFreeMargin() > (MarketInfo(_Symbol, MODE_MARGINREQUIRED) * Lots))
        {
         //--- check StopLoss
         if(StopLoss > 0)
           {
            if(StopLoss < (minSLTP + Spread))
              {
               BuySL = (Bid - (minSLTP * pips));
               Print("Broker's Minimum SL is ", minSLTP + Spread, " Pip, Automatically use Broker's Minimum SL instead. - FirstEntry");
              }
            else
              {
               BuySL = (Ask - (StopLoss * pips));
              }
           }
         else
           {
            BuySL = 0;
           }
         //--- check Take Profit
         if(TakeProfit > 0)
           {
            if(TakeProfit < minSLTP)
              {
               BuyTP = (Ask + (minSLTP * pips));
               Print("Broker's Minimum TP is ", minSLTP, " Pip, Automatically use Broker's Minimum TP instead. - FirstEntry");
              }
            else
              {
               BuyTP = (Ask + (TakeProfit * pips));
              }
           }
         int b = OrderSend(_Symbol, OP_BUY, Lots, Ask, 0, BuySL, BuyTP, EA_Name + "-" + IntegerToString(1), MagicNumber, 0, 0);
         if(b < 0)
           {
            Print("Failed to open BUY Entry T_T. Error : ", GetLastError());
           }
         else
           {
            Print("Berjaya buka Entry BUY ^_^");
           }
         buylot = Lots;
         allowbuy = false;
        }
      else
        {
         Print("Not enough margin! Account Free Margin: ", NormalizeDouble(AccountFreeMargin(), 2), " | Margin Required: ", NormalizeDouble((MarketInfo(_Symbol, MODE_MARGINREQUIRED) * Lots), 2), " | Current Buy Lot: ", Lots);
        }
     }
//---First Sell process
   if((Pos_Mode != BB) && (Allow("sell")) && (iRSI(NULL, PERIOD_H1, 14, PRICE_CLOSE, 1) > 30) && (AnalysisResult() == "Sell"))
     {
      if(AccountFreeMargin() > MarketInfo(_Symbol, MODE_MARGINREQUIRED) * Lots)
        {
         //--- check StopLoss
         if(StopLoss > 0)
           {
            if(StopLoss < (minSLTP + Spread))
              {
               SellSL = (Ask + (minSLTP * pips));
               Print("Broker's Minimum SL is ", minSLTP + Spread, " Pip, Automatically use Broker's Minimum SL instead. - FirstEntry");
              }
            else
              {
               SellSL = (Bid + (StopLoss * pips));
              }
           }
         else
           {
            SellSL = 0;
           }
         //--- check Take Profit
         if(TakeProfit > 0)
           {
            if(TakeProfit < minSLTP)
              {
               SellTP = (Bid - (minSLTP * pips));
               Print("Broker's Minimum TP is ", minSLTP, " Pip, Automatically use Broker's Minimum TP instead. - FirstEntry");
              }
            else
              {
               SellTP = (Bid - (TakeProfit * pips));
              }
           }
         int s = OrderSend(_Symbol, OP_SELL, Lots, Bid, 0, SellSL, SellTP, EA_Name + "-" + IntegerToString(1), MagicNumber, 0, 0);
         if(s < 0)
           {
            Print("Failed to open SELL Entry T_T. Error : ", GetLastError());
           }
         else
           {
            Print("Berjaya buka Entry SELL ^_^");
           }
         selllot = Lots;
         allowsell = false;
        }
      else
        {
         Print("Not enough margin! Account Free Margin: ", NormalizeDouble(AccountFreeMargin(), 2), " | Margin Required: ", NormalizeDouble((MarketInfo(_Symbol, MODE_MARGINREQUIRED) * Lots), 2), " | Current Sell Lot: ", Lots);
        }
     }
  }
//+------------------------------------------------------------------+
//|check if the position is allowed or not|
//+------------------------------------------------------------------+
bool Allow(string t)
  {
   if(Hedging)
     {
      if(CountBuy() == 0 && t == "buy")
        {
         return true;
        }
      if(CountSell() == 0 && t == "sell")
        {
         return true;
        }
     }
   else
      if(CountSell() == 0 && CountBuy() == 0)
        {
         return true;
        }
   return false;
  }
//+------------------------------------------------------------------+
//|count sell position|
//+------------------------------------------------------------------+
int CountSell()
  {
   RefreshRates();
   int k = 0;
   int index = OrdersTotal() - 1;
   while(index >= 0 && OrderSelect(index, SELECT_BY_POS, MODE_TRADES) == true)
     {
      if(OrderSymbol() == _Symbol && OrderMagicNumber() == MagicNumber)
        {
         if(OrderType() == OP_SELL)
           {
            k++;
           }
        }
      index--;
     }
   return k;
  }
//+------------------------------------------------------------------+
//|count buy position|
//+------------------------------------------------------------------+
int CountBuy()
  {
   RefreshRates();
   int k = 0;
   int index = OrdersTotal() - 1;
   while(index >= 0 && OrderSelect(index, SELECT_BY_POS, MODE_TRADES) == true)
     {
      if(OrderSymbol() == _Symbol && OrderMagicNumber() == MagicNumber)
        {
         if(OrderType() == OP_BUY)
           {
            k++;
           }
        }
      index--;
     }
   return k;
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
  }
//+------------------------------------------------------------------+
