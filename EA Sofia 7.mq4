//+------------------------------------------------------------------+
//|                                                EA Budak Ubat.mq4 |
//|                             Copyright 2016, Budak Ubat's Trading |
//|                                 https://twitter.com/SyariefAzman |
//+------------------------------------------------------------------+
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// sources161
#property version "7.00"
#property link "https://t.me/zsofia99"
#property description "This is a grid martingale EA "
#property description "recommended timeframe M5, choose ranging pair."
#property description " "
#property description "Recommended using a cent account for 100 usd capital"
#property description " "
#property description ""
#property description ""
#property description "https://t.me/zsofia99"
#property icon "\\Images\\EASofia.ico";
#property strict
#include <stdlib.mqh>
#include <WinUser32.mqh>
#define Copyright "Copyright © 2023, EA Sofia"
#property copyright Copyright
//+------------------------------------------------------------------+
//| Name of the EA                                                   |
//+------------------------------------------------------------------+
extern string EA_Name = "EA Sofia ";
string Owner = "Zarith Sofia";
string Contact = "TELEGRAM : @zsofia99";
//+------------------------------------------------------------------+
//| Authorization and Expiration date for the EA                     |
//+------------------------------------------------------------------+
datetime expDate = D'2023.10.29 23:55'; // yyyy.mm.dd<-- expired date
int allowedAccountNumbers[9999] =
  {
   271706164, 4554051, 141006588, 47095826, 4566698, 6007330, 310433370, 310432147, 310427789, 4566517, 310428731, 6007088, 310428380, 467378, 467379, 260788186, 5874167, 4566325, 310416709, 310420287, 9785154, 310417582, 310412921, 310414039, 310413555, 1600109727, 310411959, 310411239, 6005601, 260789913, 230944394, 320125264, 5864001, 260784697, 260782092, 141000344, 56129966, 56129967, 38005357, 56129965, 22595771, 330246906, 17751851, 24372660, 110019895, 53483829, 2132602615, 102865, 260772890, 38216624, 56128453, 330259968, 330261080, 6973836, 250855267, 56119492, 24440346, 20932039, 330253189, 330252350, 437814, 6002511, 330247349, 22013702, 46102642, 56126565, 120201094, 51407995, 231088399, 231080470, 231080474, 38003230, 2100200249, 192139837, 231074929, 339376, 339176, 231067931, 320321354, 231065509, 220748121, 24368645, 24368642, 24368628, 24368617, 141136159, 192080160, 192080166, 192087997, 192080154, 290729490, 220734699, 6748098, 290768531, 301326664, 301326668, 310359156, 301329698, 750729, 13027894, 13527690, 301329704, 301329710, 10576779, 56120025, 310402183, 320323525, 301329718, 320287929, 320287926, 300724432, 301329724, 38000971, 320305818, 320287928, 320287930, 290797780, 320293256, 999049102, 189402, 187461, 1000012579, 192079962, 46002444, 47074913, 301329729, 5015555, 10574113, 10574122, 2100199368, 2100102903, 301370702, 301364931, 301364963, 301363842, 22668478, 117043700, 271619370, 271619248, 271619247, 271619242, 169745, 301342826, 5103852, 10572601, 301338471, 301340934, 2100127831, 301338667, 301338700, 301338711, 60127544, 241334311, 301333295, 21327810, 62630015, 290811032, 290811144, 35124407, 226727, 271376212, 271589085, 290793203, 290803005, 290803011, 290803023, 290803031, 290803035, 290803042, 290803045, 290777186, 290777238, 5793561, 290797783, 280428807, 290708505, 290708508, 10565339, 22642646, 60124625, 290793095, 290776570, 290778420, 290791966, 290791971, 290791974, 290791975, 290791976, 290791978, 290791980, 290791982, 290790446, 60127270, 290783307, 50893152, 60127243, 9106202, 4561741, 766118, 290779891, 290777138, 4561464, 24333650, 271705126, 271702365, 271702356, 271701961, 271701959, 271701950, 271700614, 271700604, 271700600, 271698838, 58808192, 22620250, 22619162, 60126730, 271680740, 65209315, 60126358, 53409128, 2875737, 5711440, 5711469, 15769428, 112883, 271670101, 271663568, 250972252, 250979131, 4559342, 250972252, 3754760, 3754799, 60126208, 250966681, 250973804, 250966081, 800837865, 271628286, 260657559, 56105041, 250959657, 56105041, 250957659, 35055890, 2100198278, 2100198280, 2100197940, 250953184, 250951695, 250950477, 250949189, 56104289, 363317, 250937747, 2100198277, 330231524, 1149678, 5767394, 5618549, 60125487, 117017757, 220579967, 60124536, 13025770, 330226965, 60124742, 2100197910, 13025412, 5000445, 5763809, 60124966, 60124932, 5763058, 330215114, 330215118, 330215126, 5762992, 330213208, 13024948, 330212436, 60124502, 362926, 548188, 13024780, 290448830, 320247513, 5670568, 60124670, 280755909, 21454957, 53379729, 13024449, 13022238, 10565339, 60124033, 5527955, 5527967, 5586556, 5586494, 5586473, 5586460, 5585377, 60124032, 108151, 280742519, 280742542, 3751953, 280734909, 1148217, 5753815, 571958, 571729, 260753046, 260756315, 280730787, 280730796, 5585003, 13022980, 320207539, 46175797, 260764032, 260762646, 260758710, 310307023, 3957871, 5743926, 5434951, 241612110, 241612108, 27362937, 241612106, 241612105, 241612104, 241612103, 241612102, 241612100, 241612096, 241604510, 5742489, 241605261, 241617296, 443354, 22546495, 13021463, 13004694, 241591851, 290748564, 800833896, 241606464, 241605554, 231047192, 290589021, 241599814, 241599469, 13020888, 90307343, 90876405, 241598720, 241598716, 241598721, 241598555, 241598558, 241598559, 241596128, 231052121, 230942650, 241587481, 241587697, 241586738, 44094296, 5522658, 686468, 35050856, 330023862, 5724392, 220093895, 24110069, 47055958, 24390748, 220683034, 20890279, 231041409, 220670829, 231040169, 5711441, 290505538, 10565339, 51194337, 310200794, 231038313, 55006805, 231037934, 8963723, 88014706, 4457412, 6336708, 360439, 20314776, 890367718, 8002244, 5727022, 5727021, 5727019, 5727018, 5727017, 5724676, 5724673, 5724670, 5713913, 5713912, 53338904, 231036521, 10569792, 10569822, 10569823, 10569824, 10569825, 260675215, 3748617, 330032453, 220708708, 10570144, 10570145, 10570146, 10570181, 220680918, 220694255, 220703637, 10570143, 10569437, 46071377, 220698139, 290636244, 220696924, 310364137, 310364161, 320243283, 310367068, 220695974, 10569792, 220694810, 220694807, 220692136, 220692127, 10569667, 46070806, 220691140, 250852939, 438088, 220689347, 20829806, 220689025, 220689151, 241501008, 437814, 271557181, 250280548, 437834, 10568483, 90865412, 320183680, 220683034, 21398598, 229488, 46069257, 220680804, 220678889, 310390721, 220677774, 320258092, 10568801, 320236039, 5611439, 310360242, 310393621, 330179201, 5711441, 330019766, 310390036, 52133589, 310387193, 310382563, 310381317, 310362509, 310380447, 22224590, 5714333, 5713913, 5713912, 4558630, 5713692, 435807, 4558456, 310373184, 320239407, 22224590, 320206708, 320206716, 320206723, 320206732, 4558004, 310371777, 260600979, 5711107, 310364286, 33126040, 90866470, 5434953, 301318199, 310361207, 310360465, 435036, 310360389, 320259320, 310360242, 4557465, 310359156, 789012, 345678
  };
// Authorized account number
bool ignAuth = false; //ignore Authorization
string allowedAccountNames[9999] =
  {
   "Syarief Azman bin Rosli", "Syarief Azman Bin Rosli", "SYARIEF AZMAN ROSLI",
   "Mohd Nizab Pawan",
   "Nazmi Zakaria",
   "Yusrezal Bin Ramdzan", "Yusrezal Ramdzan",
   "Syed Kamal Al-Yahya Bin Syed Mohd", "Bin Syed Mohd Syed Kamal Al-Yahya",
   "Jimmy Antonio Luciano Baez", "Jimmy Luciano",
   "Ahmad Husaini Bin Shahrul Azmi", "Ahmad Husaini Shahrul Azmi",
   "Zaliha Binti Hussin", "Zaliha Hussin"
  };
string ExpiryAlert = EA_Name + " EXPIRED. "
                     "\nAccount " +
                     IntegerToString(AccountNumber()) + " is Unauthorized. "
                     "\nUse Demo account to access Trials Mode. "
                     "\nPLEASE CONTACT " +
                     Owner + " FOR MORE INFO. "
                     "\n" +
                     Contact;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

enum exc
  {
   A = 0, // on Every Tick
   B = 1, // on Every New Bar

  };
//--- input parameters
extern exc Execution_Mode = B; // Execution Mode

enum pos
  {
   AA = 0, // Buy & Sell
   BB = 1, // Buy Only
   CC = 2, // Sell Only

  };
//--- input parameters
extern pos Pos_Mode = AA; // Positions Mode

extern bool Hedging = false; // enable/disable hedging

enum entry
  {
   AAA = 0, // Classic Candle Method (Bullish Buy & Bearish Sell)
   BBB = 1, // SMA20
   CCC = 2, // Alligator
   DDD = 3, // Ichimoku
   EEE = 4, // EA Sofia (MA + MACD + Stoch)
  };
//--- input parameters
extern entry Method = EEE; // Analysis Method

extern double Lots = 0.01;                                                                     // Initial lot size
extern bool GridTrading = True;                                                                // Grid Trading
extern double MartingaleMultiplier = 1.3;                                                      // martingale multiplier
extern double MaxLot = 500;                                                                    // Maximum Lot size
extern double TakeProfit = 25.0;                                                               // take profit in pips
extern double StopLoss = 0;                                                                    // stop loss in pips
extern double minDistance = 4;                                                                 // Minimum Distance Between Orders
extern double distanceIncrement = 2.0;                                                         // Distance increment between order
extern double maxDistance = 100.0;                                                             // Maximum distance between order
extern int MaxTrade = 99999;                                                                   // Max Trade
extern bool autoCompound = true;
extern double initialCapital = 1000;
string autoconfiginfo = "--Enable this if you're not sure what the config should be--"; // --Auto Configuration below--
bool AutoConfig = false;                                                                // Automatic Config AI
string BaseSymbol = "EURUSD";                                                                  // EURUSD Symbol
int MagicNumber = 123456;

double BuySL, SellSL, buylot, selllot, BuyTP, SellTP;
double sprice, bprice;
int LotDigits; // initialized in OnInit
int SellTicket[];
int BuyTicket[];
bool allowsell, allowbuy;
double pips;
int current = 0; // current bar index, used by Cross Up, Cross Down and many other blocks

double aa;
double bb;
double cc;
double dd;

double minSLTP;
double Spread;
string desc;
bool RunOnCurrentCurrencyPair = true;
bool CloseOnlyManualTrades = false;
bool DeletePendingOrders = false;
int  MaxSlippage = 5;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---create close all button
   ObjectCreate(0, "CloseButton", OBJ_BUTTON, 0, 0, 0);
   ObjectSetInteger(0, "CloseButton", OBJPROP_XDISTANCE, 150);
   ObjectSetInteger(0, "CloseButton", OBJPROP_YDISTANCE, 100);
   ObjectSetInteger(0, "CloseButton", OBJPROP_XSIZE, 100);
   ObjectSetInteger(0, "CloseButton", OBJPROP_YSIZE, 50);
   ObjectSetString(0, "CloseButton", OBJPROP_TEXT, "Close All");
   ObjectSetInteger(0, "CloseButton", OBJPROP_COLOR, White);
   ObjectSetInteger(0, "CloseButton", OBJPROP_BGCOLOR, Red);
   ObjectSetInteger(0, "CloseButton", OBJPROP_BORDER_COLOR, Red);
   ObjectSetInteger(0, "CloseButton", OBJPROP_BORDER_TYPE, BORDER_FLAT);
   ObjectSetInteger(0, "CloseButton", OBJPROP_BACK, false);
   ObjectSetInteger(0, "CloseButton", OBJPROP_HIDDEN, true);
   ObjectSetInteger(0, "CloseButton", OBJPROP_STATE, false);
   ObjectSetInteger(0, "CloseButton", OBJPROP_FONTSIZE, 12);
   ObjectSet("CloseButton", OBJPROP_CORNER, 1);
//---
   ignoreAuth();
   ChartComment();
   double ticksize = MarketInfo(Symbol(), MODE_TICKSIZE);
   if(ticksize == 0.00001 || ticksize == 0.001)
     {
      pips = ticksize * 10;
      minSLTP = (MarketInfo(Symbol(), MODE_STOPLEVEL)) / 10;
     }
   else
     {
      pips = ticksize;
      minSLTP = (MarketInfo(Symbol(), MODE_STOPLEVEL));
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
   allowbuy = true;
   allowsell = true;
   return RunAuthorization();
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- delete close button
   ObjectDelete(0, "CloseButton");
  }
// Expert start
/*
int start()
  {
   aNewBarEVENT();
   return (0);
  }
*/
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   if(sparam == "CloseButton")
     {
      if(RunOnCurrentCurrencyPair == true && CloseOnlyManualTrades == true)
         CloseAllOrdersV01(DeletePendingOrders, MaxSlippage);
      else
         if(RunOnCurrentCurrencyPair == true && CloseOnlyManualTrades == false)
            CloseAllOrdersV02(DeletePendingOrders, MaxSlippage);
         else
            if(RunOnCurrentCurrencyPair == false && CloseOnlyManualTrades == true)
               CloseAllOrdersV03(DeletePendingOrders, MaxSlippage);
            else
               if(RunOnCurrentCurrencyPair == false && CloseOnlyManualTrades == false)
                  CloseAllOrdersV04(DeletePendingOrders, MaxSlippage);
      ObjectSetInteger(0, "CloseButton", OBJPROP_STATE, false);
     }
//---
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseAllOrdersV01(bool boolPendingOrders, int intMaxSlippage)
  {
   bool checkOrderClose = true;
   int index = OrdersTotal() - 1;
   while(index >= 0 && OrderSelect(index, SELECT_BY_POS, MODE_TRADES) == true)
     {
      if(OrderSymbol() == Symbol() && OrderMagicNumber() == 0 && (OrderType() == OP_BUY || OrderType() == OP_SELL))
        {
         checkOrderClose = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), intMaxSlippage, CLR_NONE);
        }
      else
         if(boolPendingOrders == true && OrderSymbol() == Symbol() && OrderMagicNumber() == 0 && OrderType() != OP_BUY && OrderType() != OP_SELL)
           {
            checkOrderClose = OrderDelete(OrderTicket(), CLR_NONE);
           }
      if(checkOrderClose == false)
        {
         int errorCode = GetLastError();
         if(errorCode == 1 || errorCode == 2 || errorCode == 5 || errorCode == 6 || errorCode == 64 || errorCode == 65 || errorCode == 132 || errorCode == 133 || errorCode == 139)
            break;
         else
            continue;
        }
      index--;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseAllOrdersV02(bool boolPendingOrders, int intMaxSlippage)
  {
   bool checkOrderClose = true;
   int index = OrdersTotal() - 1;
   while(index >= 0 && OrderSelect(index, SELECT_BY_POS, MODE_TRADES) == true)
     {
      if(OrderSymbol() == Symbol() && (OrderType() == OP_BUY || OrderType() == OP_SELL))
        {
         checkOrderClose = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), intMaxSlippage, CLR_NONE);
        }
      else
         if(boolPendingOrders == true && OrderSymbol() == Symbol() && OrderType() != OP_BUY && OrderType() != OP_SELL)
           {
            checkOrderClose = OrderDelete(OrderTicket(), CLR_NONE);
           }
      if(checkOrderClose == false)
        {
         int errorCode = GetLastError();
         if(errorCode == 1 || errorCode == 2 || errorCode == 5 || errorCode == 6 || errorCode == 64 || errorCode == 65 || errorCode == 132 || errorCode == 133 || errorCode == 139)
            break;
         else
            continue;
        }
      index--;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseAllOrdersV03(bool boolPendingOrders, int intMaxSlippage)
  {
   bool checkOrderClose = true;
   int index = OrdersTotal() - 1;
   while(index >= 0 && OrderSelect(index, SELECT_BY_POS, MODE_TRADES) == true)
     {
      if((OrderType() == OP_BUY || OrderType() == OP_SELL) && OrderMagicNumber() == 0)
        {
         checkOrderClose = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), intMaxSlippage, CLR_NONE);
        }
      else
         if(boolPendingOrders == true && OrderType() != OP_BUY && OrderType() != OP_SELL && OrderMagicNumber() == 0)
           {
            checkOrderClose = OrderDelete(OrderTicket(), CLR_NONE);
           }
      if(checkOrderClose == false)
        {
         int errorCode = GetLastError();
         if(errorCode == 1 || errorCode == 2 || errorCode == 5 || errorCode == 6 || errorCode == 64 || errorCode == 65 || errorCode == 132 || errorCode == 133 || errorCode == 139)
            break;
         else
            continue;
        }
      index--;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseAllOrdersV04(bool boolPendingOrders, int intMaxSlippage)
  {
   bool checkOrderClose = true;
   int index = OrdersTotal() - 1;
   while(index >= 0 && OrderSelect(index, SELECT_BY_POS, MODE_TRADES) == true)
     {
      if(OrderType() == OP_BUY || OrderType() == OP_SELL)
        {
         checkOrderClose = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), intMaxSlippage, CLR_NONE);
        }
      else
         if(boolPendingOrders == true && OrderType() != OP_BUY && OrderType() != OP_SELL)
           {
            checkOrderClose = OrderDelete(OrderTicket(), CLR_NONE);
           }
      if(checkOrderClose == false)
        {
         int errorCode = GetLastError();
         if(errorCode == 1 || errorCode == 2 || errorCode == 5 || errorCode == 6 || errorCode == 64 || errorCode == 65 || errorCode == 132 || errorCode == 133 || errorCode == 139)
            break;
         else
            continue;
        }
      index--;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool aNewBarEVENT()
  {
   static int anAlreadyObservedBarCOUNT = iBars(_Symbol, PERIOD_CURRENT); // .INIT
   if(iBars(_Symbol, PERIOD_CURRENT) > anAlreadyObservedBarCOUNT)         // .TEST
     {
      anAlreadyObservedBarCOUNT = iBars(_Symbol, PERIOD_CURRENT); // .UPD
      return (true);                                              // .ACK
     }
   else
     {
      return (false);   // .NACK
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime BarTime;
void OnEveryNewBar()
  {
   if(BarTime < Time[0])
     {
      // we have a new bar opened
      BarTime = Time[0]; // keep the new bar open time
      Main();
     }
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void Main()
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
     }
   else
     {
      buylot = Lots ;
      selllot = Lots ;
     }
   if((AutoConfig == true) && (aa > 0))
     {
      calcParam(aa, bb, cc, dd);
      TakeProfit = aa;        // stop loss in pips
      minDistance = bb;       // Minimum Distance Between Orders
      distanceIncrement = cc; // Distance increment between order
      maxDistance = dd;
      // Print("Param symbol ADR init Data --------------------------------------------------------------");
      // Print("####### Max Distance: ", maxDistance);
      // Print("####### Distance Increment: ", distanceIncrement);
      // Print("####### Min Distance: ", minDistance);
      // Print("####### TP: ", TakeProfit);
      GetLastOrder();
      if(GridTrading == True)
        {
         MartingalePosition(buylot, selllot);
        }
      FirstPosition();
      allowbuy = true;
      allowsell = true;
     }
   else
      if((AutoConfig == true) && (aa < 1))
        {
         calcParam(aa, bb, cc, dd);
         // Main();
        }
      else
        {
         //Print("Param symbol ADR init Data -------------------------------------------------------------- AutoConfig Off");
         //Print("####### Max Distance: ", maxDistance);
         //Print("####### Distance Increment: ", distanceIncrement);
         //Print("####### Min Distance: ", minDistance);
         //Print("####### TP: ", TakeProfit);
         GetLastOrder();
         if(GridTrading == True)
           {
            MartingalePosition(buylot, selllot);
           }
         FirstPosition();
         allowbuy = true;
         allowsell = true;
        }
  }
//+------------------------------------------------------------------+
//|                                                                  |
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
//|                                                                  |
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
double CommonPrice(string type)
  {
   double PriceSum = 0;
   double LotSum = 0;
   double AveragePrice = 0;
   int k = 0;
   int index = OrdersTotal() - 1;
   while(index >= 0 && OrderSelect(index, SELECT_BY_POS, MODE_TRADES) == true)
     {
      if(OrderSymbol() == _Symbol && OrderMagicNumber() == MagicNumber)
        {
         if(type == "sell" && OrderType() == OP_SELL)
           {
            PriceSum += OrderOpenPrice() * OrderLots();
            LotSum += OrderLots();
            k++;
           }
         if(type == "buy" && OrderType() == OP_BUY)
           {
            PriceSum += OrderOpenPrice() * OrderLots();
            LotSum += OrderLots();
            k++;
           }
        }
      index--;
     }
   if(LotSum > 0 && k >= 1)
     {
      AveragePrice = NormalizeDouble((PriceSum) / (LotSum), Digits());
     }
   return AveragePrice;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void FirstPosition()
  {
   if(Lots > MaxLot)
     {
      Lots = MaxLot;
     }
   if(Lots < MarketInfo(Symbol(), MODE_MINLOT))
     {
      Lots = MarketInfo(Symbol(), MODE_MINLOT);
     }
   if(Lots > MarketInfo(Symbol(), MODE_MAXLOT))
     {
      Lots = MarketInfo(Symbol(), MODE_MAXLOT);
     }
//+------------------------------------------------------------------+
//|First Buy process                                                 |
//+------------------------------------------------------------------+
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
         Print("Param symbol ADR First Buy Data --------------------------------------------------------------");
         Print("####### Max Distance: ", maxDistance);
         Print("####### Distance Increment: ", distanceIncrement);
         Print("####### Min Distance: ", minDistance);
         Print("####### TP: ", (BuyTP - Ask) / pips);
         if(CheckVolumeValue(buylot, desc))
           {
            int b = OrderSend(_Symbol, OP_BUY, buylot, Ask, 0, BuySL, BuyTP, EA_Name + "-" + IntegerToString(1), MagicNumber, 0, 0);
            if(b < 0)
              {
               Print("Failed to open BUY Entry T_T. Error : ", GetLastError());
              }
            else
              {
               Print("Berjaya buka Entry BUY ^_^");
              }
           }
         else
           {
            Print(desc);
           }
         int b = OrderSend(_Symbol, OP_BUY, buylot, Ask, 0, BuySL, BuyTP, EA_Name + "-" + IntegerToString(1), MagicNumber, 0, 0);
         if(b < 0)
           {
            Print("Failed to open BUY Entry T_T. Error : ", GetLastError());
           }
         else
           {
            Print("Berjaya buka Entry BUY ^_^");
           }
         allowbuy = false;
        }
      else
        {
         Print("Not enough margin! Account Free Margin: ", NormalizeDouble(AccountFreeMargin(), 2), " | Margin Required: ", NormalizeDouble((MarketInfo(_Symbol, MODE_MARGINREQUIRED) * Lots), 2), " | Current Buy Lot: ", Lots);
        }
     }
//+------------------------------------------------------------------+
//|First Sell process                                                |
//+------------------------------------------------------------------+
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
         Print("Param symbol ADR First Sell Data --------------------------------------------------------------");
         Print("####### Max Distance: ", maxDistance);
         Print("####### Distance Increment: ", distanceIncrement);
         Print("####### Min Distance: ", minDistance);
         Print("####### TP: ", (Bid - SellTP) / pips);
         if(CheckVolumeValue(selllot, desc))
           {
            int s = OrderSend(_Symbol, OP_SELL, selllot, Bid, 0, SellSL, SellTP, EA_Name + "-" + IntegerToString(1), MagicNumber, 0, 0);
            if(s < 0)
              {
               Print("Failed to open SELL Entry T_T. Error : ", GetLastError());
              }
            else
              {
               Print("Berjaya buka Entry SELL ^_^");
              }
           }
         else
           {
            Print(desc);
           }
         int s = OrderSend(_Symbol, OP_SELL, selllot, Bid, 0, SellSL, SellTP, EA_Name + "-" + IntegerToString(1), MagicNumber, 0, 0);
         if(s < 0)
           {
            Print("Failed to open SELL Entry T_T. Error : ", GetLastError());
           }
         else
           {
            Print("Berjaya buka Entry SELL ^_^");
           }
         allowsell = false;
        }
      else
        {
         Print("Not enough margin! Account Free Margin: ", NormalizeDouble(AccountFreeMargin(), 2), " | Margin Required: ", NormalizeDouble((MarketInfo(_Symbol, MODE_MARGINREQUIRED) * Lots), 2), " | Current Sell Lot: ", Lots);
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
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
//|                                                                  |
//+------------------------------------------------------------------+
void GetLastOrder()
  {
   int b = CountBuy();
   int s = CountSell();
   ArrayResize(BuyTicket, b, 0);
   ArrayResize(SellTicket, s, 0);
   if(b > 0)
     {
      int k = 0;
      int index = OrdersTotal() - 1;
      while(index >= 0 && OrderSelect(index, SELECT_BY_POS, MODE_TRADES) == true)
        {
         if(OrderSymbol() == _Symbol && OrderType() == OP_BUY && OrderMagicNumber() == MagicNumber)
           {
            BuyTicket[k] = OrderTicket();
            k++;
           }
         index--;
        }
      ArraySort(BuyTicket, WHOLE_ARRAY, 0, MODE_DESCEND);
     }
   if(s > 0)
     {
      int u = 0;
      int index = OrdersTotal() - 1;
      while(index >= 0 && OrderSelect(index, SELECT_BY_POS, MODE_TRADES) == true)
        {
         if(OrderSymbol() == _Symbol && OrderType() == OP_SELL && OrderMagicNumber() == MagicNumber)
           {
            SellTicket[u] = OrderTicket();
            u++;
           }
         index--;
        }
      ArraySort(SellTicket, WHOLE_ARRAY, 0, MODE_DESCEND);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void MartingalePosition(double bulot, double sellot)
  {
   int cb = CountBuy();
   int cs = CountSell();
//+------------------------------------------------------------------+
//|BUY PROCESS                                                       |
//+------------------------------------------------------------------+
   if(cb > 0 && BuyTicket[0] != 0 && OrderSelect(BuyTicket[0], SELECT_BY_TICKET) && cb < MaxTrade)
     {
      // Enter the second and subsequent trades using the incremented distance
      int cbuy = cb;
      Print("Param symbol ADR Buy Data --------------------------------------------------------------");
      Print("####### Max Distance: ", maxDistance);
      Print("####### Distance Increment: ", distanceIncrement);
      Print("####### Min Distance: ", minDistance);
      Print("####### TP: ", TakeProfit);
      double nextDistance = GetDefaultDistance(minDistance, distanceIncrement, maxDistance, cbuy);
      // enter trade with nextDistance as the distance
      if(allowbuy && ((OrderOpenPrice() - SymbolInfoDouble(_Symbol, SYMBOL_ASK)) >= (nextDistance * pips)))
        {
         bulot = buylot * MathPow(MartingaleMultiplier, cbuy);
         if(bulot > MaxLot)
           {
            bulot = MaxLot;
           }
         if(bulot < MarketInfo(Symbol(), MODE_MINLOT))
           {
            bulot = MarketInfo(Symbol(), MODE_MINLOT);
           }
         if(bulot > MarketInfo(Symbol(), MODE_MAXLOT))
           {
            bulot = MarketInfo(Symbol(), MODE_MAXLOT);
           }
         if(AccountFreeMargin() > MarketInfo(_Symbol, MODE_MARGINREQUIRED) * bulot)
           {
            if(CheckVolumeValue(bulot, desc))
              {
               int b = OrderSend(_Symbol, OP_BUY, NormalizeDouble(bulot, 2), Ask, 0, 0, 0, EA_Name + "-" + IntegerToString(cb + 1), MagicNumber, 0, 0);
               Print("Current entry Distance: ", nextDistance, " | Number of Position: ", cbuy + 1);
               allowbuy = false;
              }
            else
              {
               Print(desc);
              }
            int b = OrderSend(_Symbol, OP_BUY, NormalizeDouble(bulot, 2), Ask, 0, 0, 0, EA_Name + "-" + IntegerToString(cb + 1), MagicNumber, 0, 0);
            Print("Current entry Distance: ", nextDistance, " | Number of Position: ", cbuy + 1);
            allowbuy = false;
           }
         else
           {
            Print("Not enough margin! Account Free Margin: ", NormalizeDouble(AccountFreeMargin(), 2), " | Margin Required: ", NormalizeDouble((MarketInfo(_Symbol, MODE_MARGINREQUIRED) * bulot), 2), " | Current Buy Lot: ", NormalizeDouble(bulot, 2));
           }
        }
     }
//--- Check minimum TP
   if((TakeProfit < minSLTP) && (TakeProfit > 0))
     {
      Print("Broker's Minimum TP is ", minSLTP, " Pip, Automatically use Broker's Minimum TP instead. - Main");
      //--- Passing Variable to Modify Take Profit Function
      bprice = CommonPrice("buy");
      double bMTProfit = NormalizeDouble((bprice + (minSLTP * pips)), Digits);
      ModifyTakeProfit("buy", bMTProfit);
     }
   else     //--- Passing Variable to Modify Take Profit Function
     {
      bprice = CommonPrice("buy");
      double bMTProfit = NormalizeDouble((bprice + (TakeProfit * pips)), Digits);
      ModifyTakeProfit("buy", bMTProfit);
     }
//---
//+------------------------------------------------------------------+
//|SELL PROCESS                                                      |
//+------------------------------------------------------------------+
   if(cs > 0 && SellTicket[0] != 0 && OrderSelect(SellTicket[0], SELECT_BY_TICKET) && cs < MaxTrade)
     {
      // Enter the second and subsequent trades using the incremented distance
      int csell = cs;
      Print("Param symbol ADR SELL Data --------------------------------------------------------------");
      Print("####### Max Distance: ", maxDistance);
      Print("####### Distance Increment: ", distanceIncrement);
      Print("####### Min Distance: ", minDistance);
      Print("####### TP: ", TakeProfit);
      double nextDistance = GetDefaultDistance(minDistance, distanceIncrement, maxDistance, csell);
      // enter trade with nextDistance as the distance
      if(allowsell && ((SymbolInfoDouble(_Symbol, SYMBOL_BID) - OrderOpenPrice()) >= (nextDistance * pips)))
        {
         sellot = selllot * MathPow(MartingaleMultiplier, csell);
         if(sellot > MaxLot)
           {
            sellot = MaxLot;
           }
         if(sellot < MarketInfo(Symbol(), MODE_MINLOT))
           {
            sellot = MarketInfo(Symbol(), MODE_MINLOT);
           }
         if(sellot > MarketInfo(Symbol(), MODE_MAXLOT))
           {
            sellot = MarketInfo(Symbol(), MODE_MAXLOT);
           }
         if(AccountFreeMargin() > MarketInfo(_Symbol, MODE_MARGINREQUIRED) * sellot)
           {
            if(CheckVolumeValue(sellot, desc))
              {
               int s = OrderSend(_Symbol, OP_SELL, NormalizeDouble(sellot, 2), Bid, 0, 0, 0, EA_Name + "-" + IntegerToString(cs + 1), MagicNumber, 0, 0);
               Print("Current entry Distance: ", nextDistance, " | Number of Position: ", csell + 1);
               allowsell = false;
              }
            else
              {
               Print(desc);
              }
            int s = OrderSend(_Symbol, OP_SELL, NormalizeDouble(sellot, 2), Bid, 0, 0, 0, EA_Name + "-" + IntegerToString(cs + 1), MagicNumber, 0, 0);
            Print("Current entry Distance: ", nextDistance, " | Number of Position: ", csell + 1);
            allowsell = false;
           }
         else
           {
            Print("Not enough margin! Account Free Margin: ", NormalizeDouble(AccountFreeMargin(), 2), " | Margin Required: ", NormalizeDouble((MarketInfo(_Symbol, MODE_MARGINREQUIRED) * sellot), 2), " | Current Sell Lot: ", NormalizeDouble(sellot, 2));
           }
        }
     }
//--- Check minimum TP
   if((TakeProfit < minSLTP) && (TakeProfit > 0))
     {
      Print("Broker's Minimum TP is ", minSLTP, " Pip, Automatically use Broker's Minimum TP instead. - Main");
      //--- Passing Variable to Modify Take Profit Function
      sprice = CommonPrice("sell");
      double sMTProfit = NormalizeDouble((sprice - (minSLTP * pips)), Digits);
      ModifyTakeProfit("sell", sMTProfit);
     }
   else     //--- Passing Variable to Modify Take Profit Function
     {
      sprice = CommonPrice("sell");
      double sMTProfit = NormalizeDouble((sprice - (TakeProfit * pips)), Digits);
      ModifyTakeProfit("sell", sMTProfit);
     }
//---
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ModifyTakeProfit(string typeee, double tprofit)
  {
//+------------------------------------------------------------------+
//|Calculate SL                                                      |
//+------------------------------------------------------------------+
// Call the FindFirstOpenPositionEntryPrice function to update first entry prices
   FindFirstOpenPositionEntryPrice();
// Use these prices for setting SL for subsequent positions or any other logic.
   if((StopLoss > 0) && ((firstBuyEntryPrice > 0) || (firstSellEntryPrice > 0)))
     {
      if(StopLoss < minSLTP)
        {
         BuySL = (firstBuyEntryPrice - ((minSLTP + Spread) * pips));
         SellSL = (firstSellEntryPrice + ((minSLTP + Spread) * pips));
         Print("Broker's Minimum SL is ", minSLTP + Spread, " Pip, Automatically use Broker's Minimum SL instead. - OrderModify");
        }
      else
        {
         BuySL = (firstBuyEntryPrice - (StopLoss * pips));
         SellSL = (firstSellEntryPrice + (StopLoss * pips));
        }
     }
   else
     {
      BuySL = 0;
      SellSL = 0;
     }
//+------------------------------------------------------------------+
//| Modify Order                                                     |
//+------------------------------------------------------------------+
//  for(int i = OrdersTotal() - 1; i >= 0; i--)
   for(int i = 0; i < OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS) == false)
        {
         continue;
        }
      if(OrderSymbol() == _Symbol && OrderMagicNumber() == MagicNumber)
        {
         if((tprofit != OrderTakeProfit()) || (SellSL != 0))
           {
            if(typeee == "sell" && OrderType() == OP_SELL)
              {
               bool s = OrderModify(OrderTicket(), OrderOpenPrice(), SellSL, tprofit, 0, 0);
              }
            // else
            //   {
            //    Print("SellSL: ", SellSL);
            //    Print(GetLastError());
            //   }
            if(typeee == "buy" && OrderType() == OP_BUY)
              {
               bool b = OrderModify(OrderTicket(), OrderOpenPrice(), BuySL, tprofit, 0, 0);
              }
            // else
            //   {
            //    Print("BuySL: ", BuySL);
            //    Print(GetLastError());
            //   }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetDefaultDistance(double &miDistance, double &distancIncrement, double &maDistance, int &position)
  {
   if(maDistance < miDistance)
     {
      maDistance = miDistance;
     }
   double defaultDistance = miDistance + (position - 1) * distancIncrement;
   if(defaultDistance > maDistance)
     {
      defaultDistance = maDistance;
     }
   return defaultDistance;
  }
//+------------------------------------------------------------------+
//|The comment that will appear on chart                             |
//+------------------------------------------------------------------+
void ChartComment()
  {
//-- Get Date String
   datetime Today = StrToTime(StringConcatenate(Year(), ".", Month(), ".", Day()));
   string Date = TimeToStr(TimeCurrent(), TIME_DATE + TIME_MINUTES + TIME_SECONDS); //"yyyy.mm.dd"
//--EA Comment--
   if(isAuthorized() || IsDemo())
     {
      Comment(
         "\n ", Copyright,
         "\n ", Date, "\n",
         "\n ", AuthMessage(), "\n",
         "\n ", EA_Name,
         "\n Starting Lot: ", Lots,
         "\n Layer Multiplier: ", MartingaleMultiplier,
         "\n Equity: $", NormalizeDouble(AccountInfoDouble(ACCOUNT_EQUITY), 2),
         "\n Buy: ", CountBuy(), " | Sell: ", CountSell(),
         "\n");
     }
   else
      if(!isAuthorized() && !IsDemo() && (TimeCurrent() < expDate))
        {
         Comment(
            "\n ", Copyright,
            "\n ", Date, "\n",
            "\n ", AuthMessage(), "\n",
            "\n ", EA_Name,
            "\n Starting Lot: ", Lots,
            "\n Layer Multiplier: ", MartingaleMultiplier,
            "\n Equity: $", NormalizeDouble(AccountInfoDouble(ACCOUNT_EQUITY), 2),
            "\n Buy: ", CountBuy(), " | Sell: ", CountSell(),
            "\n\n ExpireDate: ", expDate,
            "\n");
        }
      else
        {
         // do not run EA code
         MessageBox(ExpiryAlert);
         ExpertRemove();
         Comment("\n" + ExpiryAlert);
        }
//--EA Comment--
  }
//+------------------------------------------------------------------+
//| Authorization                                                 |
//+------------------------------------------------------------------+
int accountNumber = AccountNumber();
string accountName = AccountName();
bool isAuthorized()
  {
   bool isAllowed = false;
//        for(int i = 0; i < ArraySize(allowedAccountNumbers); i++)
   for(int i = ArraySize(allowedAccountNumbers) - 1; i >= 0; i--)
     {
      if(accountNumber == allowedAccountNumbers[i] || accountName == allowedAccountNames[i])
        {
         isAllowed = true;
         break;
        }
      else
        {
         isAllowed = false;
        }
     }
   return isAllowed;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int RunAuthorization()
  {
   if(IsDemo())
     {
      // skip the authorization for demo account
      Print("Demo account detected, skipping authorization");
      return (INIT_SUCCEEDED);
     }
   if(TimeCurrent() > expDate)
     {
      if(isAuthorized())
        {
         // run EA code
         return (INIT_SUCCEEDED);
        }
      else
        {
         // do not run EA code
         MessageBox(ExpiryAlert);
         ExpertRemove();
         Comment("\n" + ExpiryAlert);
         return (INIT_FAILED);
        }
     }
   else
     {
      return (INIT_SUCCEEDED);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string AuthMessage()
  {
   if(IsDemo())
     {
      // skip the authorization for demo account
      return ("Demo account detected.\n Account Authorized.\n Account Number: " + IntegerToString(AccountNumber()) + "\n Account Name: " + AccountName());
     }
   else
      if((TimeCurrent() < expDate) && (isAuthorized() == false))
        {
         return ("Account " + IntegerToString(AccountNumber()) + " is Unauthorized, EA will expire soon.\n Trials Mode Activated.");
        }
      else
         if(RunAuthorization() == (INIT_SUCCEEDED) && IsDemo() == false)
           {
            return ("Account Authorized.\n Account Number: " + IntegerToString(AccountNumber()) + "\n Account Name: " + AccountName());
           }
         else
           {
            return (ExpiryAlert);
           }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ignoreAuth()
  {
   if(ignAuth == true)
     {
      //---ignore authorization
      ArrayFill(allowedAccountNumbers, 0, 1, AccountNumber());
      Print("allowedAccountNumbers[0]: ", allowedAccountNumbers[0]);
      //---
      return true;
     }
   else
      Print("allowedAccountNumbers[0]: ", allowedAccountNumbers[0]);
   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string AnalysisResult()   // OriginJoey
  {
   if(Method == AAA)
     {
      if(iClose(Symbol(), 0, 2) < iClose(Symbol(), 0, 1))
        {
         return "Buy";
        }
      if(iClose(Symbol(), 0, 2) > iClose(Symbol(), 0, 1))
        {
         return "Sell";
        }
      else
        {
         return "no entry";
        }
     }
   if(Method == BBB)
     {
      if(iMA(NULL, 0, 20, 0, MODE_SMA, PRICE_CLOSE, 1) < iClose(Symbol(), 0, 1))
        {
         return "Buy";
        }
      if(iMA(NULL, 0, 20, 0, MODE_SMA, PRICE_CLOSE, 1) > iClose(Symbol(), 0, 1))
        {
         return "Sell";
        }
      else
        {
         return "no entry";
        }
     }
   if(Method == CCC)
     {
      if(
         iClose(Symbol(), 0, 1) > iAlligator(NULL, PERIOD_CURRENT, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, MODE_GATORLIPS, current) && iClose(Symbol(), 0, 1) > iAlligator(NULL, PERIOD_CURRENT, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, MODE_GATORTEETH, current) && iClose(Symbol(), 0, 1) > iAlligator(NULL, PERIOD_CURRENT, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, MODE_GATORJAW, current))
        {
         return "Buy";
        }
      if(
         iClose(Symbol(), 0, 1) < iAlligator(NULL, PERIOD_CURRENT, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, MODE_GATORLIPS, current) && iClose(Symbol(), 0, 1) < iAlligator(NULL, PERIOD_CURRENT, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, MODE_GATORTEETH, current) && iClose(Symbol(), 0, 1) < iAlligator(NULL, PERIOD_CURRENT, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, MODE_GATORJAW, current))
        {
         return "Sell";
        }
      else
        {
         return "no entry";
        }
     }
   if(Method == DDD)
     {
      if(
         (iClose(Symbol(), 0, 1) > iIchimoku(NULL, PERIOD_CURRENT, 9, 26, 52, MODE_TENKANSEN, current)) && (iClose(Symbol(), 0, 1) > iIchimoku(NULL, PERIOD_CURRENT, 9, 26, 52, MODE_SENKOUSPANA, current)) && (iClose(Symbol(), 0, 1) > iIchimoku(NULL, PERIOD_CURRENT, 9, 26, 52, MODE_SENKOUSPANB, current)) && (iClose(Symbol(), 0, 1) > iIchimoku(NULL, PERIOD_CURRENT, 9, 26, 52, MODE_KIJUNSEN, current)))
        {
         return "Buy";
        }
      if(
         (iClose(Symbol(), 0, 1) < iIchimoku(NULL, PERIOD_CURRENT, 9, 26, 52, MODE_TENKANSEN, current)) && (iClose(Symbol(), 0, 1) < iIchimoku(NULL, PERIOD_CURRENT, 9, 26, 52, MODE_SENKOUSPANA, current)) && (iClose(Symbol(), 0, 1) < iIchimoku(NULL, PERIOD_CURRENT, 9, 26, 52, MODE_SENKOUSPANB, current)) && (iClose(Symbol(), 0, 1) < iIchimoku(NULL, PERIOD_CURRENT, 9, 26, 52, MODE_KIJUNSEN, current)))
        {
         return "Sell";
        }
      else
        {
         return "no entry";
        }
     }
   if(Method == EEE)
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
   else
     {
      return "no entry";
     }
// if((iAlligator(NULL, PERIOD_H4, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, MODE_GATORLIPS, current) > iAlligator(NULL, PERIOD_H4, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, MODE_GATORTEETH, current)) && (iAlligator(NULL, PERIOD_H4, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, MODE_GATORTEETH, current) > iAlligator(NULL, PERIOD_H4, 13, 8, 8, 5, 5, 3, MODE_SMMA, PRICE_MEDIAN, MODE_GATORJAW, current)) && (iAO(NULL, PERIOD_H4, current) > 0))
  }
//+------------------------------------------------------------------+
//|    AUTO CONFIG FUNCTION                                                              |
//+------------------------------------------------------------------+
void calcParam(double &TPCurr, double &minPipStepCurr, double &PipStepIncrCurr, double &maxPipStepCurr)
  {
//+------------------------------------------------------------------+
//| Detect EURUSD Automatically                                      |
//+------------------------------------------------------------------+
   int totalSymbols = SymbolsTotal(false);
   string eurusdVariation = "";
// Loop through all symbols in the market watch
   for(int i = 0; i < totalSymbols; i++)
     {
      string symbolName = SymbolName(i, false);
      if(StringFind(symbolName, BaseSymbol) != -1)
        {
         eurusdVariation = symbolName;
         // Print("Detected EURUSD variation: ", eurusdVariation);
         break;
        }
     }
   if(eurusdVariation == "")
     {
      Print("No available EURUSD variation found.");
      return;
     }
   double eurusdPrice = SymbolInfoDouble(eurusdVariation, SYMBOL_BID);
   if(eurusdPrice == 0)
     {
      Print("Unable to retrieve price for detected EURUSD variation: ", eurusdVariation);
      return;
     }
// Now you have the EURUSD price, perform your TP calculation
//   Print("Eu symbol Data --------------------------------------------------------------");
   double pipsEu;
   double ticksizeEu = MarketInfo(eurusdVariation, MODE_TICKSIZE);
   if(ticksizeEu == 0.00001 || ticksizeEu == 0.001)
     {
      pipsEu = ticksizeEu * 10;
     }
   else
     {
      pipsEu = ticksizeEu;
     }
// initialize LotDigits
   double EUMAHI = iMA(eurusdVariation, PERIOD_D1, 365, 0, MODE_SMA, PRICE_HIGH, 0);
   double EUMALO = iMA(eurusdVariation, PERIOD_D1, 365, 0, MODE_SMA, PRICE_LOW, 0);
   /*  Print(" EU MA Hi : ", EUMAHI);
     Print(" EU MA Lo : ", EUMALO);
     Print("Current Symbol : ", Symbol());
     Print("Pips EU: ", pipsEu);
   */
   double ADREu = (EUMAHI - EUMALO) / pipsEu;
//  Print("ADR Pips EU : ", ADREu);
   double TPEuDiv = ADREu / 25;
   double minPipStepDiv = ADREu / 4;
   double PipStepIncrDiv = ADREu / (2 * MathPow(MartingaleMultiplier, (CountBuy() + CountSell())));
   double maxPipStepDiv = ADREu / 100;
   /*  Print("TP Div : ", TPEuDiv);
     Print("minpipstep Div : ", minPipStepDiv);
     Print("pipstep incr Div : ", PipStepIncrDiv);
     Print("max pipstep Div : ", maxPipStepDiv);
     Print("current symbol stat --------------------------------------------------------------");
   */
//+------------------------------------------------------------------+
//| Current AutoConfig                                               |
//+------------------------------------------------------------------+
   if(TPEuDiv == 0)
     {
      Main();
     }
   else
     {
      double pipsCurr;
      double ticksize = MarketInfo(Symbol(), MODE_TICKSIZE);
      if(ticksize == 0.00001 || ticksize == 0.001)
        {
         pipsCurr = ticksize * 10;
        }
      else
        {
         pipsCurr = ticksize;
        }
      // initialize LotDigits
      double CurrMAHI = iMA(Symbol(), PERIOD_D1, 20, 0, MODE_SMA, PRICE_HIGH, 0);
      double CurrMALO = iMA(Symbol(), PERIOD_D1, 20, 0, MODE_SMA, PRICE_LOW, 0);
      /*  Print(" EU MA Hi : ", CurrMAHI);
        Print(" EU MA Lo : ", CurrMALO);
        Print("Current Symbol : ", Symbol());
        Print("Pips Curr: ", pipsCurr);
      */
      double ADRCurr = (CurrMAHI - CurrMALO) / pipsCurr;
      //  Print("ADR Pips Curr : ", ADRCurr);
      TPCurr = ADRCurr / TPEuDiv;
      minPipStepCurr = ADRCurr / minPipStepDiv;
      PipStepIncrCurr = ADRCurr / PipStepIncrDiv;
      maxPipStepCurr = ADRCurr / maxPipStepDiv;
      /*  Print("TP Curr : ", TPCurr);
        Print("minpipstep Curr : ", minPipStepCurr);
        Print("pipstep incr Curr : ", PipStepIncrCurr);
        Print("max pipstep Curr : ", maxPipStepCurr);
      */
     }
  }
//+------------------------------------------------------------------+
//|Track Position's price                                            |
//+------------------------------------------------------------------+
// Define global variables to store the first buy and sell entry prices
double firstBuyEntryPrice = 0.0;
double firstSellEntryPrice = 0.0;
// Function to find the first open position entry price for the current symbol
void FindFirstOpenPositionEntryPrice()
  {
   for(int i = 0; i < OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
         if(OrderSymbol() == Symbol())
           {
            if((OrderType() == OP_BUY) && (OrderMagicNumber() == MagicNumber))
              {
               firstBuyEntryPrice = OrderOpenPrice();
               break; // Exit the loop after finding the first buy entry price
              }
            else
               if((OrderType() == OP_SELL) && (OrderMagicNumber() == MagicNumber))
                 {
                  firstSellEntryPrice = OrderOpenPrice();
                  break; // Exit the loop after finding the first sell entry price
                 }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Check the correctness of the order volume                        |
//+------------------------------------------------------------------+
bool CheckVolumeValue(double &volume, string &description)
  {
//--- minimal allowed volume for trade operations
   double min_volume = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN);
   if(volume < min_volume)
     {
      description = StringFormat("Volume is less than the minimal allowed SYMBOL_VOLUME_MIN=%.2f", min_volume);
      return(false);
     }
//--- maximal allowed volume of trade operations
   double max_volume = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MAX);
   if(volume > max_volume)
     {
      description = StringFormat("Volume is greater than the maximal allowed SYMBOL_VOLUME_MAX=%.2f", max_volume);
      return(false);
     }
//--- get minimal step of volume changing
   double volume_step = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_STEP);
   int ratio = (int)MathRound(volume / volume_step);
   if(MathAbs(ratio * volume_step - volume) > 0.0000001)
     {
      description = StringFormat("Volume is not a multiple of the minimal step SYMBOL_VOLUME_STEP=%.2f, the closest correct volume is %.2f",
                                 volume_step, ratio * volume_step);
      volume = ratio * volume_step;
      return(false);
     }
   description = "Correct volume value";
   return(true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   ChartComment();
   if(Execution_Mode == B)
     {
      OnEveryNewBar();
     }
   else
      if(Execution_Mode == A)
        {
         Main();
        }
  }
//+------------------------------------------------------------------+
