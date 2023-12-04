create database if not exists flightsdb;
use flightsdb;
create external table if not exists flights (
  AIRLINE_CODE string,
  DEPARTURE_DELAY int
)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/flightsdb.db/flights';

create external table if not exists airlines (
  IATA_CODE string,
  AIRLINE_NAME string
)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/flightsdb.db/airlines';

create external table if not exists top_airlines (
    AIRLINE_CODE string,
    AIRLINE_NAME string,
    DEPARTURE_DELAY float

)
row format delimited
fields terminated by ','
lines terminated by '\n'
stored as textfile location 'hdfs://namenode:8020/user/hive/warehouse/flightsdb.db/top_airlines';


