#!/bin/sh

curl \
   http://localhost:3000/graphql \
  --silent \
  -X POST \
  -H "Content-Type: application/json" \
  --data '{"query":"query NearbyDeals($lat: Float!, $long: Float!) {\n  deals(lat: $lat, long: $long) {\n    id\n    title\n    place {\n      id\n      name\n      distance\n    }\n  }\n}\n","variables":{"lat":64.68375,"long":24.47645},"operationName":"NearbyDeals"}' \
| python -m json.tool