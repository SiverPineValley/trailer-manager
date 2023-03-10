CREATE TABLE "trailer" (
                           "tid" uuid PRIMARY KEY,
                           "tnum" varchar NOT NULL,
                           "created_at" timestamp DEFAULT (now()),
                           "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "sensor" (
                          "sid" varchar PRIMARY KEY,
                          "uid" uuid,
                          "lat" varchar,
                          "lon" varchar,
                          "wifi_loc" varchar[],
                          "battery" int,
                          "created_at" timestamp DEFAULT (now()),
                          "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "trailer_sensor_map" (
                                      "seq" serial PRIMARY KEY,
                                      "tid" uuid NOT NULL,
                                      "sid" varchar NOT NULL,
                                      "created_at" timestamp DEFAULT (now()),
                                      "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "sensor_log" (
                              "seq" serial PRIMARY KEY,
                              "sid" varchar NOT NULL,
                              "uid" uuid NOT NULL,
                              "tid" uuid NOT NULL,
                              "real_creaetd_at" timestamp DEFAULT (now())
);

CREATE TABLE "gps_log" (
                           "sid" varchar PRIMARY KEY,
                           "lat" varchar NOT NULL,
                           "lon" varchar NOT NULL,
                           "speed" numeric,
                           "wifi_loc" varchar[],
                           "battery" int,
                           "real_creaetd_at" timestamp DEFAULT (now())
);

CREATE TABLE "user" (
                        "uid" uuid PRIMARY KEY,
                        "name" varchar NOT NULL,
                        "email" varchar NOT NULL,
                        "mobile" varchar NOT NULL,
                        "birthdate" varchar NOT NULL,
                        "created_at" timestamp DEFAULT (now()),
                        "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "user_role" (
                             "uid" uuid PRIMARY KEY,
                             "role" varchar NOT NULL,
                             "created_at" timestamp DEFAULT (now()),
                             "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "user_auth" (
                             "uid" uuid PRIMARY KEY,
                             "salt" varchar NOT NULL,
                             "password" varchar NOT NULL,
                             "created_at" timestamp DEFAULT (now()),
                             "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "user_cert" (
                             "uid" uuid PRIMARY KEY,
                             "ci" varchar NOT NULL,
                             "di" varchar NOT NULL,
                             "created_at" timestamp DEFAULT (now()),
                             "updated_at" timestamp DEFAULT (now())
);

CREATE INDEX "sensor_log_index" ON "sensor_log" ("sid", "uid", "tid");

CREATE INDEX "gps_log_index" ON "gps_log" ("sid", "real_creaetd_at");

COMMENT ON COLUMN "trailer"."tid" IS '???????????? ID';

COMMENT ON COLUMN "trailer"."tnum" IS '???????????? ??????';

COMMENT ON COLUMN "sensor"."sid" IS '?????? ????????? ??????';

COMMENT ON COLUMN "sensor"."uid" IS '?????? ?????? ?????? ?????? ID';

COMMENT ON COLUMN "sensor"."lat" IS '?????? ?????? ??????';

COMMENT ON COLUMN "sensor"."lon" IS '?????? ?????? ??????';

COMMENT ON COLUMN "sensor"."wifi_loc" IS 'WIFI ???????????? (SSID)';

COMMENT ON COLUMN "trailer_sensor_map"."seq" IS '?????? ?????? ??????';

COMMENT ON COLUMN "trailer_sensor_map"."tid" IS '???????????? ID';

COMMENT ON COLUMN "trailer_sensor_map"."sid" IS '?????? ????????? ??????';

COMMENT ON COLUMN "sensor_log"."seq" IS '?????? ?????? ??????';

COMMENT ON COLUMN "sensor_log"."sid" IS '?????? ????????? ??????';

COMMENT ON COLUMN "sensor_log"."uid" IS '?????? ?????? ?????? ?????? ID';

COMMENT ON COLUMN "sensor_log"."tid" IS '?????? ?????? ???????????? ID';

COMMENT ON COLUMN "gps_log"."sid" IS '?????? ????????? ??????';

COMMENT ON COLUMN "gps_log"."lat" IS '??????';

COMMENT ON COLUMN "gps_log"."lon" IS '??????';

COMMENT ON COLUMN "gps_log"."speed" IS '??????';

COMMENT ON COLUMN "gps_log"."wifi_loc" IS 'WIFI ???????????? (SSID)';

COMMENT ON COLUMN "user"."uid" IS '????????? ID';

COMMENT ON COLUMN "user"."name" IS '????????? ???';

COMMENT ON COLUMN "user"."email" IS '????????? ?????????';

COMMENT ON COLUMN "user"."mobile" IS '????????? ????????? ??????';

COMMENT ON COLUMN "user"."birthdate" IS '????????? ????????????';

COMMENT ON COLUMN "user_role"."uid" IS '????????? ID';

COMMENT ON COLUMN "user_role"."role" IS '????????? ??????';

COMMENT ON COLUMN "user_auth"."uid" IS '????????? ID';

COMMENT ON COLUMN "user_auth"."salt" IS '???????????? Salt';

COMMENT ON COLUMN "user_auth"."password" IS '????????????';

COMMENT ON COLUMN "user_cert"."uid" IS '????????? ID';

COMMENT ON COLUMN "user_cert"."ci" IS '???????????? CI';

COMMENT ON COLUMN "user_cert"."di" IS '???????????? DI';

ALTER TABLE "trailer_sensor_map" ADD FOREIGN KEY ("tid") REFERENCES "trailer" ("tid");

ALTER TABLE "trailer_sensor_map" ADD FOREIGN KEY ("sid") REFERENCES "sensor" ("sid");

ALTER TABLE "sensor_log" ADD FOREIGN KEY ("sid") REFERENCES "sensor" ("sid");

ALTER TABLE "sensor_log" ADD FOREIGN KEY ("uid") REFERENCES "user" ("uid");

ALTER TABLE "gps_log" ADD FOREIGN KEY ("sid") REFERENCES "sensor" ("sid");

ALTER TABLE "user_auth" ADD FOREIGN KEY ("uid") REFERENCES "user" ("uid");

ALTER TABLE "user_cert" ADD FOREIGN KEY ("uid") REFERENCES "user" ("uid");
