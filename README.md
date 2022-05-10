# README

A simple Chat application built with Ruby on Rails  

## Start the app

- **docker**: docker-compose up
- **localy**: ``` 
bundle install
db:create
db:migrate
db:seed
rails s
```

## Endpoints  

## Apps  

#### index apps
```
curl --location --request GET 'http://localhost:3000/api/v1/apps/' \
--header 'Content-Type: application/json' \
}'
```
response:
```json
[
    {
        "name": "app 1",
        "token": "EJAM7rVS3kubGNkhTJriyj9k",
        "chats_count": 0
    },
    {
        "name": "app 2",
        "token": "HQMtuD89k3LB7Ly8m36DWNnD",
        "chats_count": 2
    }
]
```
#### create a new app
```
curl --location --request POST 'http://localhost:3000/api/v1/apps/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "app 3"
}'
```
response:
```json
{
    "name": "app 3",
    "token": "NkhTJHQMtuD89k37rVS3kubG",
    "chats_count": 0
}
```
#### get app by token
```
curl --location --request GET 'http://localhost:3000/api/v1/apps/NkhTJHQMtuD89k37rVS3kubG/' \
--header 'Content-Type: application/json' \
}'
```
response:
```json
{
    "name": "app 3",
    "token": "NkhTJHQMtuD89k37rVS3kubG",
    "chats_count": 0
}
```

## Chats
#### index chats by app token
```
curl --location --request GET 'http://localhost:3000/api/v1/apps/NkhTJHQMtuD89k37rVS3kubG/chats/' \
--header 'Content-Type: application/json' \
}'
```
response:
```json
[
  {
    "number": 2,
    "app_token": "HQMtuD89k3LB7Ly8m36DWNnD",
    "messages_count": 1
  },
  {
    "number": 1,
    "app_token": "HQMtuD89k3LB7Ly8m36DWNnD",
    "messages_count": 10
  }
]
```

#### create a new chat for at a certain app
```
curl --location --request POST 'http://localhost:3000/api/v1/apps/NkhTJHQMtuD89k37rVS3kubG/chats/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "content": "Hello!"
}'
}'
```
response:
```json
{
  "number": 3,
  "app_token": "HQMtuD89k3LB7Ly8m36DWNnD",
  "messages_count": 0
}
```
## Messages
#### index chats by app token
```
curl --location --request GET 'http://localhost:3000/api/v1/apps/NkhTJHQMtuD89k37rVS3kubG/chats/1/messages' \
--header 'Content-Type: application/json' \
}'
```
response:
```json
[
  {
    "number": 1,
    "chat_number": 1,
    "content": "Hello!"
  },
  {
    "number": 2,
    "chat_number": 1,
    "content": "Hi"
  }
]
```

#### create a new message
```
curl --location --request POST 'http://localhost:3000/api/v1/apps/NkhTJHQMtuD89k37rVS3kubG/chats/1/messages/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "content": "How are you?!"
}'
}'
```
response:
```json
{
  "number": 3,
  "chat_number": 1,
  "content": "How are you?!"
}
```
#### search chat messages
```
curl --location --request GET 'http://localhost:3000/api/v1/apps/HQMtuD89k3LB7Ly8m36DWNnD/chats/1/messages/search?query=hello' \
--header 'Content-Type: application/json' \
}'
```
response:
```json
[
  {
    "number": 1,
    "chat_number": 1,
    "content": "Hello!"
  }
]
```


##Notes
- the app is working fine locally. Had some issues with Docker and didn't have the time to fully configure it. also was planning to write specs but was short on time
- for giving each chat/message a number staring from 1 for each app/chat respectively, i stored the chats_count for each app, and messages_count for each chat, at redis
- for handling concurrency and race-conditions, i applied mutex on accessing redis database
- for updating the columns chats_count for each app and messages_count for each chat, i created a cron task that runs every 30 minutes with sidekiq that updates these columns
- for avoiding direct writing to MYSQL at creating chats/messages, delegated the creation to sidekiq so it can process all the creations sequentially 
