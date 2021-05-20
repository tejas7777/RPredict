def getStockPrices(datestring, equity):
    # ------- Attributes --------------------

    # ----parameters----
    # datestring: String representing date in yyyy-mm-dd
    # equite: String representing name of the equity

    # ----returns----
    # List containing stock values

    # ----- date processing -------------------
    print(datestring)
    #2020-05-05
    #['2020',05,02]
    # Converts yyyy-mm-dd to [yyy,mm,dd]
    datelist = datestring.split('-')
    print(datelist)
    # Converts to integer
    for i in range(len(datelist)):
        datelist[i] = int(datelist[i])
    print(datelist)
    # Given Date
    #1008909998
    date1 = str(int(datetime.datetime(datelist[0], datelist[1], datelist[2], 0, 0).timestamp()))
    # Next Day
    
    date2 = str(int((datetime.datetime.fromtimestamp(int(date1)) + datetime.timedelta(days=4)).timestamp()))

    print(date1, date2)

    # API url
    url = "https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-historical-data"

    # Preparing the API request
    querystring = {"frequency": "1d", "filter": "history", "period1": date1, "period2": date2, "symbol": equity}

    headers = {
        'x-rapidapi-host': "apidojo-yahoo-finance-v1.p.rapidapi.com",
        'x-rapidapi-key': "1d6ddb15cfmsh659278d46d1db71p11143djsnd83b099aaca8"
    }

    # Send the API request and recieve the response
    #Make a GET Request
    response = requests.request("GET", url, headers=headers, params=querystring)
    print(response)
    # Get the JSON from request format
    responsejson = response.json()
    # The JSON would be in the following format
    print(responsejson)

    # Now we will parse the JSON to get prices
    pricelist = responsejson['prices']
    print(pricelist)
    stocks = []
    tempstocks = []
    for x in pricelist:
        tempstocks.append(x['close'])

    stocks = tempstocks[0:2]

    print(tempstocks)
    print(stocks)
    # returns the stock price for two days
    return stocks
