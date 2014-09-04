Q = require 'q'
request = require 'request'
FeedParser = require 'feedparser'

SYOBOCAL_ID  = process.env['AK_SYOBOCAL_ID']
API_KEY      = process.env['AK_API_KEY']
API_SECRET   = process.env['AK_API_SECRET']
TOKEN        = process.env['AK_TOKEN']
TOKEN_SECRET = process.env['AK_TOKEN_SECRET']

fetchPrograms = ->
  req = request
    url: 'http://cal.syoboi.jp/rss.php'
    qs:
      filter:   '0'
      usr:      SYOBOCAL_ID
      titlefmt: '$(Mark) [$(ChName)] $(Title) $(SubTitleB) $(StTime) ~'
      
  feedparser = new FeedParser()
  req.pipe(feedparser)

  deferred = Q.defer()
  feedparser.on 'error', (error) ->
    deferred.reject(error)
  feedparser.on 'data', (data) ->
    deferred.notify(data)
  feedparser.on 'end', () ->
    deferred.resolve()

  deferred.promise

truncateToMinutes = (date) ->
  new Date( Math.floor(date.getTime() / (60 * 1000)) * (60 * 1000) )

isIn10Minutes = (date) ->
  now = truncateToMinutes(new Date()).getTime()
  after10Minutes = now + 10 * 60 * 1000
  now < date.getTime() && date.getTime() <= after10Minutes

tweet = (message) ->
  request
    method: 'POST'
    url:    'https://api.twitter.com/1.1/statuses/update.json'
    oauth:
      consumer_key:    API_KEY
      consumer_secret: API_SECRET
      token:           TOKEN
      token_secret:    TOKEN_SECRET
    form:
      status: message
    (error, response, body) ->
      if not (response.statusCode in [200, 201])
        console.log(body)

lookAround = ->
  fetchPrograms().then () ->
    console.log('tweeted')
  .progress (article) ->
    if isIn10Minutes(article.date)
      formattedTitle = article.title.replace(/\s?\d\d\/\d\d\s(\d\d:\d\d) ~$/, '$1 ~')
      console.log(formattedTitle)
      tweet(formattedTitle)
  .fail (error) ->
    console.log('error: ' + error)

start = ->
  console.log('started Anime Kansai for syobocal id:' + SYOBOCAL_ID)
  setInterval ->
    minute = new Date().getMinutes()
    if minute in [0, 10, 20, 30, 40, 50]
      lookAround()
  , 60 * 1000

start()
