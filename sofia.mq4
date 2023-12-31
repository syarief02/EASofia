//+------------------------------------------------------------------+
//| Jurus Trading Awan & Bada9 Recognition v1.0                      |
//|                                                                  |
//| Copyright © 2005, PuteraBayang @ ShadowPrince                    |
//| (Arash Rashid Al-Saadi)                                          |
//| http://www.tradervenger.com                                      |
//|                                                                  |
//| This is still work in progress and needs LOTS of testing         |
//+------------------------------------------------------------------+
#property copyright "Ownership         : Arash Rashid Al-Saadi @ PuteraBayang / ShadowPrince"

#include <stdlib.mqh>
#include <stderror.mqh>

extern double TP_Points = 100;
extern double SL_Points = 100;
extern int Period1 = 3;
extern int MA_Shift = 0;
extern int Shift = 0;
extern int Period2 = 5;
extern int MA_Shift2 = 0;
extern int Shift3 = 0;
extern int _K_period = 9;
extern int _D_period = 3;
extern int Slowing = 5;
extern int Shift4 = 0;
extern int _K_period1 = 9;
extern int _D_period1 = 3;
extern int Slowing2 = 5;
extern int Shift5 = 0;
int LotDigits; //initialized in OnInit
extern int MagicNumber = 1859680;
extern int NextOpenTradeAfterBars = 0; //next open trade after time
extern double MM_Martingale_Start = 0.1;
extern double MM_Martingale_ProfitFactor = 1;
extern double MM_Martingale_LossFactor = 2;
extern bool MM_Martingale_RestartProfit = true;
extern bool MM_Martingale_RestartLoss = true;
extern int MM_Martingale_RestartLosses = 1000;
extern int MM_Martingale_RestartProfits = 1000;
extern int MaxSlippage = 3; //slippage, adjusted in OnInit
bool crossed[4]; //initialized to true, used in function Cross
int MaxOpenTrades = 1000;
int MaxLongTrades = 1000;
int MaxShortTrades = 1000;
int MaxPendingOrders = 1000;
int MaxLongPendingOrders = 1000;
int MaxShortPendingOrders = 1000;
extern bool Hedging = true;
int OrderRetry = 5; //# of retries if sending order returns error
int OrderWait = 5; //# of seconds to wait if sending order returns error
double myPoint; //initialized in OnInit

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double MM_Size() //martingale / anti-martingale
  {
   double lots = MM_Martingale_Start;
   double MaxLot = MarketInfo(Symbol(), MODE_MAXLOT);
   double MinLot = MarketInfo(Symbol(), MODE_MINLOT);
   if(SelectLastHistoryTrade())
     {
      double orderprofit = OrderProfit();
      double orderlots = OrderLots();
      double boprofit = BOProfit(OrderTicket());
      if(orderprofit + boprofit > 0 && !MM_Martingale_RestartProfit)
         lots = orderlots * MM_Martingale_ProfitFactor;
      else
         if(orderprofit + boprofit < 0 && !MM_Martingale_RestartLoss)
            lots = orderlots * MM_Martingale_LossFactor;
         else
            if(orderprofit + boprofit == 0)
               lots = orderlots;
     }
   if(ConsecutivePL(false, MM_Martingale_RestartLosses))
      lots = MM_Martingale_Start;
   if(ConsecutivePL(true, MM_Martingale_RestartProfits))
      lots = MM_Martingale_Start;
   if(lots > MaxLot)
      lots = MaxLot;
   if(lots < MinLot)
      lots = MinLot;
   return(lots);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Cross(int i, bool condition) //returns true if "condition" is true and was false in the previous call
  {
   bool ret = condition && !crossed[i];
   crossed[i] = condition;
   return(ret);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void myAlert(string type, string message)
  {
   if(type == "print")
      Print(message);
   else
      if(type == "error")
        {
         Print(type + " | zarith @ " + Symbol() + "," + IntegerToString(Period()) + " | " + message);
        }
      else
         if(type == "order")
           {
           }
         else
            if(type == "modify")
              {
              }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TradesCount(int type) //returns # of open trades for order type, current symbol and magic number
  {
   int result = 0;
   int total = OrdersTotal();
   for(int i = 0; i < total; i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES) == false)
         continue;
      if(OrderMagicNumber() != MagicNumber || OrderSymbol() != Symbol() || OrderType() != type)
         continue;
      result++;
     }
   return(result);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool SelectLastHistoryTrade()
  {
   int lastOrder = -1;
   int total = OrdersHistoryTotal();
   for(int i = total - 1; i >= 0; i--)
     {
      if(!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
         continue;
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber)
        {
         lastOrder = i;
         break;
        }
     }
   return(lastOrder >= 0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double BOProfit(int ticket) //Binary Options profit
  {
   int total = OrdersHistoryTotal();
   for(int i = total - 1; i >= 0; i--)
     {
      if(!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
         continue;
      if(StringSubstr(OrderComment(), 0, 2) == "BO" && StringFind(OrderComment(), "#" + IntegerToString(ticket) + " ") >= 0)
         return OrderProfit();
     }
   return 0;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ConsecutivePL(bool profits, int n)
  {
   int count = 0;
   int total = OrdersHistoryTotal();
   for(int i = total - 1; i >= 0; i--)
     {
      if(!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
         continue;
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber)
        {
         double orderprofit = OrderProfit();
         double boprofit = BOProfit(OrderTicket());
         if((!profits && orderprofit + boprofit >= 0) || (profits && orderprofit + boprofit <= 0))
            break;
         count++;
        }
     }
   return(count >= n);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime LastCloseTime()
  {
   if(SelectLastHistoryTrade())
     {
      return(OrderCloseTime());
     }
   return(0);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int myOrderSend(int type, double price, double volume, string ordername) //send order, return ticket ("price" is irrelevant for market orders)
  {
   if(!IsTradeAllowed())
      return(-1);
   int ticket = -1;
   int retries = 0;
   int err = 0;
   int long_trades = TradesCount(OP_BUY);
   int short_trades = TradesCount(OP_SELL);
   int long_pending = TradesCount(OP_BUYLIMIT) + TradesCount(OP_BUYSTOP);
   int short_pending = TradesCount(OP_SELLLIMIT) + TradesCount(OP_SELLSTOP);
   string ordername_ = ordername;
   if(ordername != "")
      ordername_ = "(" + ordername + ")";
//test Hedging
   if(!Hedging && ((type % 2 == 0 && short_trades + short_pending > 0) || (type % 2 == 1 && long_trades + long_pending > 0)))
     {
      myAlert("print", "Order" + ordername_ + " not sent, hedging not allowed");
      return(-1);
     }
//test maximum trades
   if((type % 2 == 0 && long_trades >= MaxLongTrades)
      || (type % 2 == 1 && short_trades >= MaxShortTrades)
      || (long_trades + short_trades >= MaxOpenTrades)
      || (type > 1 && type % 2 == 0 && long_pending >= MaxLongPendingOrders)
      || (type > 1 && type % 2 == 1 && short_pending >= MaxShortPendingOrders)
      || (type > 1 && long_pending + short_pending >= MaxPendingOrders)
     )
     {
      myAlert("print", "Order" + ordername_ + " not sent, maximum reached");
      return(-1);
     }
//prepare to send order
   while(IsTradeContextBusy())
      Sleep(100);
   RefreshRates();
   if(type == OP_BUY)
      price = Ask;
   else
      if(type == OP_SELL)
         price = Bid;
      else
         if(price < 0) //invalid price for pending order
           {
            myAlert("order", "Order" + ordername_ + " not sent, invalid price for pending order");
            return(-1);
           }
   int clr = (type % 2 == 1) ? clrRed : clrBlue;
   while(ticket < 0 && retries < OrderRetry + 1)
     {
      ticket = OrderSend(Symbol(), type, NormalizeDouble(volume, LotDigits), NormalizeDouble(price, Digits()), MaxSlippage, 0, 0, ordername, MagicNumber, 0, clr);
      if(ticket < 0)
        {
         err = GetLastError();
         myAlert("print", "OrderSend" + ordername_ + " error #" + IntegerToString(err) + " " + ErrorDescription(err));
         Sleep(OrderWait * 1000);
        }
      retries++;
     }
   if(ticket < 0)
     {
      myAlert("error", "OrderSend" + ordername_ + " failed " + IntegerToString(OrderRetry + 1) + " times; error #" + IntegerToString(err) + " " + ErrorDescription(err));
      return(-1);
     }
   string typestr[6] = {"Buy", "Sell", "Buy Limit", "Sell Limit", "Buy Stop", "Sell Stop"};
   myAlert("order", "Order sent" + ordername_ + ": " + typestr[type] + " " + Symbol() + " Magic #" + IntegerToString(MagicNumber));
   return(ticket);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int myOrderModifyRel(int ticket, double SL, double TP) //modify SL and TP (relative to open price), zero targets do not modify
  {
   if(!IsTradeAllowed())
      return(-1);
   bool success = false;
   int retries = 0;
   int err = 0;
   SL = NormalizeDouble(SL, Digits());
   TP = NormalizeDouble(TP, Digits());
   if(SL < 0)
      SL = 0;
   if(TP < 0)
      TP = 0;
//prepare to select order
   while(IsTradeContextBusy())
      Sleep(100);
   if(!OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES))
     {
      err = GetLastError();
      myAlert("error", "OrderSelect failed; error #" + IntegerToString(err) + " " + ErrorDescription(err));
      return(-1);
     }
//prepare to modify order
   while(IsTradeContextBusy())
      Sleep(100);
   RefreshRates();
//convert relative to absolute
   if(OrderType() % 2 == 0) //buy
     {
      if(NormalizeDouble(SL, Digits()) != 0)
         SL = OrderOpenPrice() - SL;
      if(NormalizeDouble(TP, Digits()) != 0)
         TP = OrderOpenPrice() + TP;
     }
   else //sell
     {
      if(NormalizeDouble(SL, Digits()) != 0)
         SL = OrderOpenPrice() + SL;
      if(NormalizeDouble(TP, Digits()) != 0)
         TP = OrderOpenPrice() - TP;
     }
   if(CompareDoubles(SL, 0))
      SL = OrderStopLoss(); //not to modify
   if(CompareDoubles(TP, 0))
      TP = OrderTakeProfit(); //not to modify
   if(CompareDoubles(SL, OrderStopLoss()) && CompareDoubles(TP, OrderTakeProfit()))
      return(0); //nothing to do
   while(!success && retries < OrderRetry + 1)
     {
      success = OrderModify(ticket, NormalizeDouble(OrderOpenPrice(), Digits()), NormalizeDouble(SL, Digits()), NormalizeDouble(TP, Digits()), OrderExpiration(), CLR_NONE);
      if(!success)
        {
         err = GetLastError();
         myAlert("print", "OrderModify error #" + IntegerToString(err) + " " + ErrorDescription(err));
         Sleep(OrderWait * 1000);
        }
      retries++;
     }
   if(!success)
     {
      myAlert("error", "OrderModify failed " + IntegerToString(OrderRetry + 1) + " times; error #" + IntegerToString(err) + " " + ErrorDescription(err));
      return(-1);
     }
   string alertstr = "Order modified: ticket=" + IntegerToString(ticket);
   if(!CompareDoubles(SL, 0))
      alertstr = alertstr + " SL=" + DoubleToString(SL);
   if(!CompareDoubles(TP, 0))
      alertstr = alertstr + " TP=" + DoubleToString(TP);
   myAlert("modify", alertstr);
   return(0);
  }

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//initialize myPoint
   myPoint = Point();
   if(Digits() == 5 || Digits() == 3)
     {
      myPoint *= 10;
      MaxSlippage *= 10;
     }
//initialize LotDigits
   double LotStep = MarketInfo(Symbol(), MODE_LOTSTEP);
   if(NormalizeDouble(LotStep, 3) == round(LotStep))
      LotDigits = 0;
   else
      if(NormalizeDouble(10 * LotStep, 3) == round(10 * LotStep))
         LotDigits = 1;
      else
         if(NormalizeDouble(100 * LotStep, 3) == round(100 * LotStep))
            LotDigits = 2;
         else
            LotDigits = 3;
   int i;
//initialize crossed
   for(i = 0; i < ArraySize(crossed); i++)
      crossed[i] = true;
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   int ticket = -1;
   double price;
   double TP;
   double SL;
//Open Buy Order, instant signal is tested first
   if(Cross(0, iMA(NULL, PERIOD_CURRENT, Period1, MA_Shift, MODE_LWMA, PRICE_CLOSE, Shift) > iMA(NULL, PERIOD_CURRENT, Period2, MA_Shift2, MODE_LWMA, PRICE_CLOSE, Shift3)) //Moving Average crosses above Moving Average
      && Cross(1, iStochastic(NULL, PERIOD_CURRENT, _K_period, _D_period, Slowing, MODE_LWMA, 1, MODE_MAIN, Shift4) > iStochastic(NULL, PERIOD_CURRENT, _K_period1, _D_period1, Slowing2, MODE_SMA, 1, MODE_SIGNAL, Shift5)) //Stochastic Oscillator crosses above Stochastic Oscillator
     )
     {
      RefreshRates();
      price = Ask;
      TP = TP_Points * myPoint; //Take Profit = value in points (relative to price)
      SL = SL_Points * myPoint; //Stop Loss = value in points (relative to price)
      if(TradesCount(OP_BUY) + TradesCount(OP_SELL) > 0 || TimeCurrent() - LastCloseTime() < NextOpenTradeAfterBars * PeriodSeconds())
         return; //next open trade after time after previous trade's close
      if(IsTradeAllowed())
        {
         ticket = myOrderSend(OP_BUY, price, MM_Size(), "");
         if(ticket <= 0)
            return;
        }
      else //not autotrading => only send alert
         myAlert("order", "");
      myOrderModifyRel(ticket, SL, TP);
     }
//Open Sell Order, instant signal is tested first
   if(Cross(2, iMA(NULL, PERIOD_CURRENT, Period1, MA_Shift, MODE_LWMA, PRICE_CLOSE, Shift) < iMA(NULL, PERIOD_CURRENT, Period2, MA_Shift2, MODE_LWMA, PRICE_CLOSE, Shift3)) //Moving Average crosses below Moving Average
      && Cross(3, iStochastic(NULL, PERIOD_CURRENT, _K_period, _D_period, Slowing, MODE_LWMA, 1, MODE_MAIN, Shift4) < iStochastic(NULL, PERIOD_CURRENT, _K_period1, _D_period1, Slowing2, MODE_SMA, 1, MODE_SIGNAL, Shift5)) //Stochastic Oscillator crosses below Stochastic Oscillator
     )
     {
      RefreshRates();
      price = Bid;
      TP = TP_Points * myPoint; //Take Profit = value in points (relative to price)
      SL = SL_Points * myPoint; //Stop Loss = value in points (relative to price)
      if(TradesCount(OP_BUY) + TradesCount(OP_SELL) > 0 || TimeCurrent() - LastCloseTime() < NextOpenTradeAfterBars * PeriodSeconds())
         return; //next open trade after time after previous trade's close
      if(IsTradeAllowed())
        {
         ticket = myOrderSend(OP_SELL, price, MM_Size(), "");
         if(ticket <= 0)
            return;
        }
      else //not autotrading => only send alert
         myAlert("order", "");
      myOrderModifyRel(ticket, SL, TP);
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
