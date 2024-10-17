-- -------------------------------------------------------------
-- TablePlus 6.1.8(574)
--
-- https://tableplus.com/
--
-- Database: baemin_db
-- Generation Time: 2024-10-17 11:00:19.8090 AM
-- -------------------------------------------------------------


-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS category_category_id_seq;

-- Table Definition
CREATE TABLE "public"."category" (
    "category_id" int4 NOT NULL DEFAULT nextval('category_category_id_seq'::regclass),
    "category_name" varchar(255),
    "deleted" bool DEFAULT false,
    PRIMARY KEY ("category_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS order_cart_order_cart_id_seq;

-- Table Definition
CREATE TABLE "public"."order_cart" (
    "order_cart_id" int4 NOT NULL DEFAULT nextval('order_cart_order_cart_id_seq'::regclass),
    "product_id" int4,
    "quantity" int4,
    "order_id" varchar(255),
    PRIMARY KEY ("order_cart_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS order_tracking_order_tracking_id_seq;

-- Table Definition
CREATE TABLE "public"."order_tracking" (
    "order_tracking_id" int4 NOT NULL DEFAULT nextval('order_tracking_order_tracking_id_seq'::regclass),
    "order_id" varchar(255),
    "tracking_id" int4,
    "active" bool,
    PRIMARY KEY ("order_tracking_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."orders" (
    "order_id" varchar(255) NOT NULL,
    "date" date,
    "store_id" int4,
    "user_id" int4,
    "payment" varchar(255),
    "address" varchar(255),
    "note" varchar(255),
    "fee" int4,
    "discount" int4,
    "tracking_id" int4,
    "deleted" bool DEFAULT false,
    PRIMARY KEY ("order_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS product_product_id_seq;

-- Table Definition
CREATE TABLE "public"."product" (
    "product_id" int4 NOT NULL DEFAULT nextval('product_product_id_seq'::regclass),
    "product_name" varchar(255),
    "price" int4,
    "description" varchar(255),
    "stock" int4,
    "store_id" int4,
    "img" varchar(255),
    "category_id" int4,
    PRIMARY KEY ("product_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS store_store_id_seq;

-- Table Definition
CREATE TABLE "public"."store" (
    "store_id" int4 NOT NULL DEFAULT nextval('store_store_id_seq'::regclass),
    "store_name" varchar(255),
    "store_address" varchar(255),
    "category_id" int4,
    "img" varchar(255),
    "deleted" bool DEFAULT false,
    PRIMARY KEY ("store_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS tracking_tracking_id_seq;

-- Table Definition
CREATE TABLE "public"."tracking" (
    "tracking_id" int4 NOT NULL DEFAULT nextval('tracking_tracking_id_seq'::regclass),
    "tracking_status" varchar(255),
    PRIMARY KEY ("tracking_id")
);

-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS users_user_id_seq;

-- Table Definition
CREATE TABLE "public"."users" (
    "user_id" int4 NOT NULL DEFAULT nextval('users_user_id_seq'::regclass),
    "user_name" varchar(255),
    "phone_number" varchar(255),
    "email" varchar(255),
    "password" varchar(255),
    "user_role" varchar(255),
    PRIMARY KEY ("user_id")
);

INSERT INTO "public"."category" ("category_id", "category_name", "deleted") VALUES
(1, 'Fast Food', 'f'),
(2, 'Vietnamese Food', 'f'),
(3, 'Asian Cuisine', 'f');

INSERT INTO "public"."order_cart" ("order_cart_id", "product_id", "quantity", "order_id") VALUES
(47, 1, 2, 'e9d86a0a-d05e-4fe6-80d2-5fb59d59bfd0'),
(48, 3, 1, 'e9d86a0a-d05e-4fe6-80d2-5fb59d59bfd0'),
(49, 1, 2, '64bcc178-8902-4684-95a1-2b89f11595ef'),
(50, 3, 1, '64bcc178-8902-4684-95a1-2b89f11595ef'),
(51, 1, 2, '3d0eb20f-366a-4a70-a54a-387dce7c4123'),
(52, 3, 1, '3d0eb20f-366a-4a70-a54a-387dce7c4123'),
(53, 1, 2, '8437ecff-19eb-479e-921a-4b5dc56d9e52'),
(54, 3, 1, '8437ecff-19eb-479e-921a-4b5dc56d9e52'),
(55, 1, 2, '05c8b8e3-5ebe-424f-b302-335d1608afb8'),
(56, 3, 1, '05c8b8e3-5ebe-424f-b302-335d1608afb8');

INSERT INTO "public"."order_tracking" ("order_tracking_id", "order_id", "tracking_id", "active") VALUES
(21, 'e9d86a0a-d05e-4fe6-80d2-5fb59d59bfd0', 1, 't'),
(22, '64bcc178-8902-4684-95a1-2b89f11595ef', 1, 't'),
(23, '3d0eb20f-366a-4a70-a54a-387dce7c4123', 1, 't'),
(24, '8437ecff-19eb-479e-921a-4b5dc56d9e52', 1, 't'),
(25, '05c8b8e3-5ebe-424f-b302-335d1608afb8', 1, 't');

INSERT INTO "public"."orders" ("order_id", "date", "store_id", "user_id", "payment", "address", "note", "fee", "discount", "tracking_id", "deleted") VALUES
('05c8b8e3-5ebe-424f-b302-335d1608afb8', '2024-10-17', 1, 7, 'Credit Card', '123 Example Street', 'micro 1051', 5000, 1000, 1, 'f'),
('3d0eb20f-366a-4a70-a54a-387dce7c4123', '2024-10-17', 1, 7, 'Credit Card', '123 Example Street', 'micro 852', 5000, 1000, 1, 'f'),
('64bcc178-8902-4684-95a1-2b89f11595ef', '2024-10-17', 1, 7, 'Credit Card', '123 Example Street', 'micro 852', 5000, 1000, 1, 'f'),
('8437ecff-19eb-479e-921a-4b5dc56d9e52', '2024-10-17', 1, 7, 'Credit Card', '123 Example Street', 'micro 852', 5000, 1000, 1, 'f'),
('e9d86a0a-d05e-4fe6-80d2-5fb59d59bfd0', '2024-10-17', 1, 7, 'Credit Card', '123 Example Street', 'micro 732', 5000, 1000, 1, 'f');

INSERT INTO "public"."product" ("product_id", "product_name", "price", "description", "stock", "store_id", "img", "category_id") VALUES
(1, 'Fried Chicken', 50000, 'Crispy fried chicken', 44, 1, 'https://s.net.vn/s0dv', 1),
(2, 'Hamburger', 40000, 'Beef burger with vegetables', 191, 1, 'https://s.net.vn/r2Lq', 1),
(3, 'Cheeseburger', 45000, 'Burger with cheese', 121, 2, 'https://s.net.vn/r2Lq', 1),
(4, 'Pho Tai', 60000, 'Traditional Vietnamese noodle soup with rare beef', 20, 3, 'https://s.net.vn/16UN', 2),
(5, 'Pho Nam', 60000, 'Vietnamese noodle soup with brisket', 40, 3, 'https://s.net.vn/16UN', 2),
(6, 'Whopper', 50000, 'Large burger with beef patty', 114, 4, 'https://s.net.vn/r2Lq', 1),
(7, 'Pepperoni Pizza', 80000, 'Pizza with pepperoni toppings', 70, 5, 'https://s.net.vn/16y7', 1),
(8, 'Veggie Pizza', 75000, 'Pizza with vegetables', 60, 5, 'https://s.net.vn/16y7', 1),
(9, 'Grilled Chicken', 55000, 'Grilled chicken with spices', 90, 1, 'https://s.net.vn/s0dv', 1),
(10, 'Fish Fillet', 48000, 'Fried fish fillet sandwich', 90, 2, 'https://s.net.vn/r2Lq', 1),
(11, 'Chicken Pho', 60000, 'Vietnamese noodle soup with chicken', 40, 3, 'https://s.net.vn/16UN', 2),
(12, 'Bacon Burger', 52000, 'Burger with bacon and cheese', 130, 2, 'https://s.net.vn/16y7', 1),
(13, 'Spicy Chicken Burger', 45000, 'Spicy fried chicken burger', 107, 1, 'https://s.net.vn/16y7', 1),
(14, 'Shrimp Pho', 70000, 'Vietnamese noodle soup with shrimp', 30, 3, 'https://s.net.vn/16UN', 2),
(15, 'Meat Lover Pizza', 85000, 'Pizza with various meats', 50, 5, 'https://s.net.vn/16y7', 1),
(16, 'Cheesy Fries', 30000, 'Fries topped with melted cheese', 194, 4, 'https://s.net.vn/s0dv', 1),
(17, 'Chicken Wings', 45000, 'Spicy chicken wings', 150, 1, 'https://s.net.vn/s0dv', 1),
(18, 'Beef Steak', 120000, 'Grilled beef steak', 80, 2, 'https://s.net.vn/16y7', 1),
(19, 'Vegetarian Pho', 60000, 'Vietnamese noodle soup with vegetables', 35, 3, 'https://s.net.vn/16UN', 2),
(20, 'Double Cheeseburger', 48000, 'Burger with double cheese', 140, 4, 'https://s.net.vn/16y7', 1),
(21, 'Hawaiian Pizza', 82000, 'Pizza with ham and pineapple', 44, 5, 'https://s.net.vn/16y7', 1),
(22, 'BBQ Chicken Pizza', 85000, 'Pizza with BBQ chicken', 54, 5, 'https://s.net.vn/16y7', 1),
(23, 'Spicy Pho', 65000, 'Spicy Vietnamese noodle soup', 40, 3, 'https://s.net.vn/16UN', 2),
(24, 'Caesar Salad', 35000, 'Salad with chicken and Caesar dressing', 100, 1, 'https://s.net.vn/16y7', 1),
(25, 'Chicken Nuggets', 32000, 'Fried chicken nuggets', 180, 1, 'https://s.net.vn/16y7', 1),
(26, 'Double Whopper', 60000, 'Double patty burger', 110, 4, 'https://s.net.vn/16y7', 1),
(27, 'Supreme Pizza', 87000, 'Pizza with supreme toppings', 50, 5, 'https://s.net.vn/16y7', 1),
(28, 'Beef Burrito', 55000, 'Burrito with beef and vegetables', 100, 2, 'https://s.net.vn/16y7', 1),
(29, 'Spaghetti Bolognese', 70000, 'Spaghetti with meat sauce', 80, 1, 'https://s.net.vn/16y7', 1),
(30, 'French Fries', 20000, 'Crispy French fries', 300, 1, 'https://s.net.vn/r2Lq', 3);

INSERT INTO "public"."store" ("store_id", "store_name", "store_address", "category_id", "img", "deleted") VALUES
(1, 'KFC', 'q1', 1, 'https://s.net.vn/PNCs', 'f'),
(2, 'McDonalds', 'q2', 1, 'https://s.net.vn/QO09', 'f'),
(3, 'Pho 24', 'q3', 2, 'https://s.net.vn/arxr', 'f'),
(4, 'Burger King', 'q4', 1, 'https://s.net.vn/ZRkb', 'f'),
(5, 'Pizza Hut', 'q5', 1, 'https://s.net.vn/OF9G', 'f');

INSERT INTO "public"."tracking" ("tracking_id", "tracking_status") VALUES
(1, 'Nhà hàng đã nhận đơn'),
(2, 'Shipper đã nhận đơn'),
(3, 'Shipper đang đến nhà hàng'),
(4, 'Shipper đã đến nhà hàng'),
(5, 'Shipper đang giao hàng'),
(6, 'Đơn hàng hoàn tất');

INSERT INTO "public"."users" ("user_id", "user_name", "phone_number", "email", "password", "user_role") VALUES
(0, 'koi', '12123', '0302211421@caothang.edu.vn', '$2b$10$wviPtY68YIoCrE6BpFJI4Os/wFCfb8V3SqD0tUQOyyOoAEnCW84a6', 'user'),
(1, 'John Doe', '0123456789', 'johndoe@gmail.com', 'password123', 'customer'),
(2, 'Jane Smith', '0987654321', 'janesmith@gmail.com', 'password456', 'customer'),
(3, 'Admin User', '0112233445', 'admin@restaurant.com', 'adminpass', 'admin'),
(7, 'khoi dang', '090209020902', 'khoidang2110@gmail.com', '$2b$10$W3BIRP5ueSRvA7uZq2aZKOMWeOcFD8sm2S0R5G.ChuUL/DEj0RfE6', 'user'),
(82, 'ha tran', '090209020902', 'hatran2110@gmail.com', '$2b$10$fEipl6dNZiqZuvKv6DGaIOOvkcbAq8r6zgXYjIZBCGZHG7mYMe/fS', 'user');

ALTER TABLE "public"."order_cart" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orders"("order_id");
ALTER TABLE "public"."order_cart" ADD FOREIGN KEY ("product_id") REFERENCES "public"."product"("product_id");
ALTER TABLE "public"."order_tracking" ADD FOREIGN KEY ("tracking_id") REFERENCES "public"."tracking"("tracking_id");
ALTER TABLE "public"."order_tracking" ADD FOREIGN KEY ("order_id") REFERENCES "public"."orders"("order_id");
ALTER TABLE "public"."orders" ADD FOREIGN KEY ("tracking_id") REFERENCES "public"."tracking"("tracking_id");
ALTER TABLE "public"."orders" ADD FOREIGN KEY ("store_id") REFERENCES "public"."store"("store_id");
ALTER TABLE "public"."orders" ADD FOREIGN KEY ("user_id") REFERENCES "public"."users"("user_id");
ALTER TABLE "public"."product" ADD FOREIGN KEY ("store_id") REFERENCES "public"."store"("store_id");
ALTER TABLE "public"."product" ADD FOREIGN KEY ("category_id") REFERENCES "public"."category"("category_id");
ALTER TABLE "public"."store" ADD FOREIGN KEY ("category_id") REFERENCES "public"."category"("category_id");
