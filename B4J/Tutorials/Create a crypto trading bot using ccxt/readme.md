### Create a crypto trading bot using ccxt by cyiwin
### 01/31/2023
[B4X Forum - B4J - Tutorials](https://www.b4x.com/android/forum/threads/145808/)

![](https://www.b4x.com/android/forum/attachments/138711)  
  
   
Hello all,  
  
I made a template to save time when creating a crypto trading bot with B4j. I'm posting this "as-is" for now, since I'm currently working on Tradingview's pine script to create a strategy (or use someone else's) and automate trades with webhooks and PHP. But, if you have a lot of time on your hands and want to create a crypto trading bot using B4J, this may be of some use for you.  
  
This guide is detailed for Windows OS using a XAMPP server but may be adapted to your situation.  
  
Order of operation: B4J -> php server with ccxt -> exchange API -> php returns json to B4J.  
  
Ccxt is a useful open source program that unifies the API interface between multiple exchanges. It has been developed for php, Java and Python. I believe you should utilize ccxt whenever possible.  

- most of the tedious work has already been done by other programmers.
- It will be easier to reuse your program if/when you move to another exchange. Ccxt uses unified symbols and methods across multiple exchanges.
- It's open source and has an active community so it gets regular updates.

  
Just a note about security, I'm no expert but here is what I do:  

- I put the API Key and Secret in a file outside of my server root with an obscure name.
- I don't allow any API withdrawals when I create a new API key from an exchange.
- I have a static IP and whitelist it with my crypto exchanges whenever possible.
- I only keep enough funds at an exchange that is necessary. Please don't use exchanges as wallets. They do at times "go bankrupt" and take all your funds, especially in the bear markets.
- I use a dedicated computer as a server that doesn't have a lot of software installed. I also don't allow remote access to the server unless I have to.

You too can be on your way with these six maybe-not-so easy steps:  
  
**1) Get a PHP server.  
2) Download ccxt and place it in your php root.  
3) Install Composer to handle dependencies.  
4) Download/copy 'API\_call.php' and place it in your root php folder.  
5) Place 'file.file' in the directory before root. This holds your API keys and secrets.  
6) Run The Stuff**  
  
Details:  
  
1) Get a php server. I like using a local server like XAMPP. It's fairly easy to download and install. I'm using [XAMPP](https://www.apachefriends.org/download.html) 8.1.12, it seems to work best (as of 25-Jan-2023).  
  
2) Download the current version of [ccxt](https://github.com/ccxt/ccxt). Follow the instructions from github ccxt on how to install ccxt using php. If using XAMPP, just put the 'ccxt-master' folder into your XAMPP htdocs folder. (I renamed mine to 'ccxt')  
  
3) Install [Composer](https://getcomposer.org/download/) to automatically install the dependencies you'll need for ccxt with php.  

- Enable gmp in your php.ini file. (C:\xampp\php\php.ini) search php.ini for “gmp”, remove the “;” to uncomment “extension=gmp”, save file.
- Download and run the automatic installer for composer.
- Open cmd window. Type "composer", you should see composer working from any directory. If not, you may have to locate composer in your Windows environment variables Path.
- cd to ccxt directory (C:\xampp\htdocs\ccxt)
- type "composer install" or “composer update”. If all goes well, composer finds the 'composer.json' file and installs the required dependencies.

[INDENT=2]*→ If “composer install” gives you an error: You may need to add xampp and/or composer PATH to Windows Environment Variables (google “xampp php path”). You may need to install github. You may need PHP version 8.1 or higher. If you have PHP 8.2.0 or higher, you may need to install/enable php\_zip.dll in php.ini. Good Luck this part, it can be a pain.*[/INDENT]  

- In the cmd window, cd to PHP root directory (c:\xampp\htdocs), type “composer require vlucas/phpdotenv”. You should now see a "vendor" folder in your htdocs. This lets you store API keys outside of the php root directory which should be out of reach for most online hackers (unless you computer is compromised).

  
4,5) Create "API\_call.php" and place it into your root directory (c:\xampp\htdocs).  
  

```B4X
<?php  
$debug = false;  
  
date_default_timezone_set ('UTC');  
include 'ccxt/ccxt.php';                                // where you put ccxt.php in relation to this program  
include_once __DIR__ . '/vendor/autoload.php';  
  
//get the API key stuffs, put them in your environment variables  
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../', 'file.file');  
$dotenv->load();  
  
// ***Example exchanges, Create your own exchange Variables here**************************  
$binanceus_1_key = $_ENV['bincanceus_1_key'];  
$binanceus_1_secret = $_ENV['binanceus_1_secret'];  
  
$kraken_1_key = $_ENV['kraken_1_key'];  
$kraken_1_secret = $_ENV['kraken_1_secret'];  
  
$bittrex_1_key = $_ENV['bittrex_1_key'];  
$bittrex_1_secret = $_ENV['bittrex_1_secret'];  
  
$coinbaseadvanced_1_key = $_ENV['coinbaseadvanced_1_key'];  
$coinbaseadvanced_1_secret = $_ENV['coinbaseadvanced_1_secret'];  
  
  
// *****************************************************************************************************  
  
function my_echo($text) {  
    global $debug;                                        // use global variable $debug inside the function  
//    if ($debug == true) { echo "$text" . "<br>"; }                //looks better in browser  
    if ($debug == true) { echo "$text" . " : "; }                    //looks better in b4j logs  
}  
  
function Get($value, $default_value) {                                                            //$_GET if exsist, else return a default value  
    if (isset($_GET[$value])) {  
        $value = $_GET[$value];  
        return $value;  
    } else {  
        return $default_value;  
    }  
}  
  
$bot = Get("bot", "no bot");                                            // $_GET bot or default to 'bot'  
$command = Get("command", "no command");  
//$scoin = 'USD';  
  
my_echo ('$bot = ' . $bot);  
my_echo ('$command = ' . $command);  
  
switch ($bot) {  
  
    case 'binanceus_1':                                                                // "new" creates a new object from a class  
        $exchange = new ccxt\binanceus (array (  
        'apiKey' => $binanceus_1_key,  
        'secret' => $binanceus_1_secret,  
        'enableRateLimit' => true,  
        ));  
        break;  
          
    case 'kraken_1':  
        $exchange = new ccxt\kraken (array (  
        'apiKey' => $kraken_1_key,  
        'secret' => $kraken_1_secret,  
        'enableRateLimit' => true,  
        ));  
        break;  
          
    case 'bittrex_1':  
        $exchange = new ccxt\bittrex (array (     
        'apiKey' => $bittrex_1_key,  
        'secret' => $bittrex_1_secret,  
        'enableRateLimit' => true,  
        ));  
        break;  
          
    case 'coinbase_adv_1':                                                            // not supported by ccxt yet, as of 29-Jan-2023  
        $exchange = new ccxt\coinbaseadvanced (array (  
        //'password' => '',  
        'apiKey' => $coinbaseadvanced_1_key,  
        'secret' => $coinbaseadvanced_1_secret,  
        'enableRateLimit' => true,  
        ));  
        break;  
          
    default:        // no bot selected  
          
}  
  
try {  
    $res = array('API_call.php', 'found', 'no', 'JSON');  
    if ($bot == "no bot") $res = "Choose a bot First";  
      
    //———————————————————-    Public Calls  
    switch ($command) {  
    case 'Test_PHP':  
        $res = "API_call.php successful!!!  ccxt requires PHP 7.0+, your PHP version: " . phpversion();  
        break;  
          
    case 'Test_CCXT':  
        $res = "CCXT v." . \ccxt\Exchange::VERSION;  
        break;  
          
    case 'exchanges':  
        $res = \ccxt\Exchange::$exchanges;    //Static properties are accessed using the Scope Resolution Operator ( :: ) and cannot be accessed through the object operator ( -> ).  
        break;  
          
    case 'exchange_info':  
        if ($bot != 'bot') $res = $exchange->describe(array('has'));  
        //$res = $exchange->describe(array('id'));  
        break;  
          
    case 'fetch_markets':  
        $res = $exchange->fetch_markets(array());  
        break;  
          
    case 'fetch_ticker':  
        $symbol = Get("symbol", null);  
        $res = $exchange->fetch_ticker ($symbol, array());  
        break;  
          
    case 'fetch_tickers':  
        //$symbol = Get('symbol', null);  
        $res = $exchange->fetch_tickers ();  
        break;  
          
    case 'fetch_l2_order_book':  
        $symbol = Get("symbol", null);  
        $limit = Get("limit", null);  
        $res = $exchange->fetch_l2_order_book($symbol, $limit, array());  
        //$res = $exchange->fetch_order_book($symbol, 30, array());                // can give more data than l2 orderbook  
        break;  
          
    case 'fetch_ohlcv':  
        $symbol = Get("symbol", null);  
        $timeframe = Get("timeframe", null);  
        $since = Get("since", null);                                //optional  
        $limit = Get("limit", null);                                    //optional  
        $res = $exchange->fetch_ohlcv($symbol, $timeframe, $since, $limit, array ());  
        break;  
      
    case 'build_ohlcvc':    //Doesn't work  
        $symbol = Get("symbol", null);  
        $timeframe = Get("timeframe", null);  
        $since = Get("since", null);                                //optional  
        $limit = Get("limit", null);                                    //optional  
        $res = $exchange->fetch_ohlcvc($symbol, $timeframe, $since, $limit, array());  
        break;  
          
    case 'fetch_trades':  
        $symbol = Get("symbol", null);  
        $since = Get("since", null);                            //optional  
        $limit = Get("limit", null);                                //optional  
        $res = $exchange->fetch_trades($symbol, $since, $limit, array());  
        break;  
      
      
    //———————————————————-    Private Calls  
    case 'fetch_balance':  
        $res = $exchange->fetch_balance(array());  
        break;  
          
    case 'fetch_open_orders':                                    //single coinpair  
        $symbol = Get("symbol", null);  
        $since = Get("since", null);                            //optional  
        $limit = Get("limit", null);                                //optional  
        $res = $exchange->fetch_open_orders($symbol, $since, $limit, array());  
        break;  
          
    case 'fetch_all_open_orders':                                //most exchanges allow all coinpairs at once?  
        $symbols = $exchange->symbols;                    //$symbols = array('ADA/BTC', 'MANA/BTC');  
        $since = Get("since", null);                            //optional  
        $limit = Get("limit", null);                                //optional  
        $res = $exchange->fetch_open_orders($symbols, $since, $limit, array());  
        //fetch_open_orders($symbol = null, $since = null, $limit = null, $params = array ()  
        break;  
          
    case 'fetch_my_trades':  
        $symbol = Get("symbol", null);  
        $since = Get("since", null);                        //optional  
        $limit = Get("limit", null);                            //optional  
        $res = $exchange->fetch_my_trades($symbol, $since, $limit, array());  
        break;  
          
    case 'fetch_all_my_trades':                            //All Coins History doesn't work with many exchanges  
        $symbols = $exchange->symbols;  
        $since = Get("since", null);                        //optional  
        $limit = Get("limit", null);                            //optional  
        $res = $exchange->fetch_my_trades($symbols, $since, $limit, array());  
        break;  
          
    case 'create_limit_buy_order':  
        $symbol = Get("symbol", null);  
        $amount = Get("amount", null);  
        $price = Get("price", null);  
        $res = $exchange->create_limit_buy_order($symbol, $amount, $price, array());  
        break;  
          
    case 'create_limit_sell_order':  
        $symbol = Get("symbol", null);  
        $amount = Get("amount", null);  
        $price = Get("price", null);  
        $res = $exchange->create_limit_sell_order($symbol, $amount, $price, array());  
        break;  
          
    case 'edit_limit_order':  
        $id = Get("id", null);  
        $symbol = Get("symbol", null);  
        $side = Get("side", null);  
        $amount = Get("amount", null);  
        $price = Get("price", null);  
        $res = $exchange->edit_limit_order($id, $symbol, $side, $amount, $price, array());  
        break;  
          
    case 'create_market_buy_order':  
        $symbol = Get("symbol", null);  
        $amount = Get("amount", null);  
        $res = $exchange->create_market_buy_order($symbol, $amount, array());  
        break;  
          
    case 'create_market_sell_order':  
        $symbol = Get("symbol", null);  
        $amount = Get("amount", null);  
        $res = $exchange->create_market_sell_order($symbol, $amount, array());  
        break;  
          
    case 'cancel_order':  
        $id = Get("id", null);  
        $res = $exchange->cancel_order($id, null, array());  
        //$symbol = Get("symbol", null);  
        //$res = $exchange->cancel_order($id, $symbol, array());  
        break;  
          
    case 'cancel_orders':  
        $ids = Get("ids", null);  
        $res = $exchange->cancelOrders($ids, array());  
        break;  
          
    case 'cancel_all_orders':  
        $res = $exchange->cancel_all_orders(null, array());  
        break;  
          
    default:  
        echo 'Api.call.php  $command: "' . $command . '" not found. <br>';  
    }    //end switch  
      
//    $json_res = json_encode($res, JSON_UNESCAPED_SLASHES). "\n";  
$json_res = json_encode($res, JSON_UNESCAPED_SLASHES);                // get rid of the \/'s  
echo ($json_res);  
  
// handle error  
} catch (\ccxt\NetworkError $e) {  
    echo '(Network Error) ' . $e->getMessage () . "\n";  
//    echo $e->getMessage () . "\n";  
} catch (\ccxt\ExchangeError $e) {  
    echo '(Exchange Error) ' . $e->getMessage () . "\n";  
//    echo $e->getMessage () . "\n";  
} catch (Exception $e) {  
    echo '(Error) ' . $e->getMessage () . "\n";  
//    echo $e->getMessage () . "\n";  
}  
  
?>
```

  

- Create 'file.file' in one directory up from 'API\_call.php' (c:\xampp).

```B4X
bincanceus_1_key = "your API key"  
binanceus_1_secret = "your API secret"  
  
kraken_1_key = "your API key"  
kraken_1_secret = "your API secret"  
  
bittrex_1_key = "your API key"  
bittrex_1_secret = "your API secret"  
  
coinbaseadvanced_1_key = "your API key"  
coinbaseadvanced_1_secret = "your API secret"
```

  

- Add your api keys and secrets to 'file.file' using the example format. 'API\_call.php' will pull data from this file.
*→ You can rename 'file.file' to anything you like, Just don't name it 'api\_keys.txt'! You will also have to update its name on line 9 of 'API\_call.php' to access it.*- Modify the key/secret variables in 'API\_call.php' under line 12, "Example exchanges" section. These should match the names you created in 'file.file'.
- Remember to update your case 'variable names' in the 'switch ($bot)[' section of 'API\_call.php' after line 49.

6) Run the Stuff:  

- 'file.file' (or whatever you named it) should have your API keys.
- 'API\_Call.php' should be edited with your bot names.
- Open XAMPP control panel and "Start" Apache (for PHP)
- Open '\_Bot\_Template.b4j'. At line 40, edit the create bot area with your own bot.
- Run '\_Bot\_Template.b4j'

[INDENT]

1. click on "Test\_PHP" to make sure you server is working.
2. click on "Test\_CCXT" to make sure ccxt is in the right place and working.
3. click the top left combo box, if you created a bot in b4j, it should be there.
4. now you should be able to try the "fetch\_balance" button.
5. use the other combo boxes to select your primary and secondary coin.
6. try the different API calls to see what your exchange allows (FYI, create\_limit\_buy/sell\_order will actually place a tiny BTC/USD order!)

[/INDENT]  
  
I know this can be a lot… So, to recap, for this to work you should have a running php server using composer and these 5 files installed:  

- 'vendor' in 'c:\xampp\htdocs'. Created when you typed “composer require vlucas/phpdotenv” from step 3).
- 'file.file' in 'c:\xampp'. Updated by you with your api keys.
- 'API\_call.php' in 'c:\xampp\htdocs'. Updated by you with your variables that grab info from 'file.file'.
- the github ccxt code in folder 'c:\xampp\htdocs\ccxt\'. (when you go to this folder you should see folders 'build', 'dist', 'doc', 'examples', 'js', etc…)
- '\_Bot\_Template.b4j'

Uses Libraries: CSSUtils, jOkHttpUtils2, Json, jXUI