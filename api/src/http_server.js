const express = require('express');
const bodyParser = require('body-parser');
const { graphqlExpress, graphiqlExpress } = require('apollo-server-express');
const { makeExecutableSchema } = require('graphql-tools');

const config = require("./config");
const { get_db, configure_logging, get_banner } = require("./common");

const logger = configure_logging(config.http_server);

const db = get_db(config);

//=============================================================================
// Server config
//=============================================================================

const app = express();

app.listen(config.http_server.port, config.http_server.host, () => {
  banner_msg = get_banner()
  .concat([
    `\nHTTP Server listening on ` +
      `${config.http_server.host}:${config.http_server.port}`
  ])
  .join("\n");
  logger.info(banner_msg);
});

// The GraphQL schema in string form
const typeDefs = `
  type Query { deals(lat:Float!, long:Float!): [Deal] }
  type Deal { id: String, title: String, place: Place }
  type Place { id:String, name: String, distance:Float}
`;

// The resolvers
const resolvers = {
  Query: { deals: (obj, {lat, long}, context, info) => {
    return new Promise((resolve, reject) => {
      db.query(near_deals_q, [lat, long, 1000], (err, result) => {
        if (err) reject(err);
        items = serialise_deals(result.rows);
        resolve(items)
      })
    });
  }
}
};

const schema = makeExecutableSchema({
  typeDefs,
  resolvers
});

//=============================================================================
// Routes
//=============================================================================

//CORS
// app.all("/*", (req, res, next) => {
//   res.header("Access-Control-Allow-Origin", "*");
//   res.header("Access-Control-Allow-Headers", "X-Requested-With");
//   next();
// });

app.use('/graphql', bodyParser.json(), graphqlExpress({ schema: schema }));
app.get('/graphiql', graphiqlExpress({ endpointURL: '/graphql' })); // if you want GraphiQL enabled

//=============================================================================
// Queries
//=============================================================================

const near_deals_q = `
  with 
    context as (select ST_MakePoint($1, $2) as reference_point)
  select 
    places.id as place_id,
    places.name as place_name,
    deals.id as deal_id,
    deals.title as deal_title,
    ST_Distance(coords::geometry(Point), (select reference_point from context)) as distance
  from
    places
  join
    deals on deals.place_id = places.id
  where
    ST_DWithin (coords::geometry(Point), (select reference_point from context), $3)
  order by
    distance desc`;

//=============================================================================
// Serialisers
//=============================================================================

const serialise_deals = list => list.map(serialise_deal);

const serialise_deal = ({
  place_id,
  place_name,
  deal_id,
  deal_title,
  distance,
}) => ({
  place:{
    id: place_id,
    name: place_name,
    distance,
  },
  id: deal_id,
  title: deal_title,
  distance,
});