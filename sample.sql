CREATE TABLE `menu_menuitem` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(100) NOT NULL,
    `price` numeric(6, 2) NOT NULL
);

CREATE TABLE `menu_menuitem` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `name` varchar(100) NOT NULL,
    `price` numeric(6, 2) NOT NULL
);

CREATE TABLE `order_order` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `created_at` datetime(6) NOT NULL
);

CREATE TABLE `order_orderitem` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `quantity` integer UNSIGNED NOT NULL CHECK (`quantity` >= 0),
    `created` datetime(6) NOT NULL,
    `item_id` bigint NOT NULL,
    `order_id` bigint NOT NULL
);

ALTER TABLE
    `order_order`
ADD
    COLUMN `user_id` integer NOT NULL,
ADD
    CONSTRAINT `order_order_user_id_7cf9bc2b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user`(`id`);

ALTER TABLE
    `order_orderitem`
ADD
    CONSTRAINT `order_orderitem_item_id_ade63ba0_fk_menu_menuitem_id` FOREIGN KEY (`item_id`) REFERENCES `menu_menuitem` (`id`);

ALTER TABLE
    `order_orderitem`
ADD
    CONSTRAINT `order_orderitem_order_id_aba34f44_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`);

CREATE TABLE `reservation_reservation` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `date` date NOT NULL,
    `time` time(6) NOT NULL,
    `guest_name` varchar(225) NOT NULL,
    `created` datetime(6) NOT NULL,
    `user_id` integer NOT NULL
);

ALTER TABLE
    `reservation_reservation`
ADD
    CONSTRAINT `reservation_reservation_user_id_261c5876_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Create model Reservation
--
CREATE TABLE `reservation_reservation` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `date` date NOT NULL,
    `time` time(6) NOT NULL,
    `guest_name` varchar(225) NOT NULL,
    `created` datetime(6) NOT NULL,
    `user_id` integer NOT NULL
);

ALTER TABLE
    `reservation_reservation`
ADD
    CONSTRAINT `reservation_reservation_user_id_261c5876_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

CREATE TABLE `delivery_delivery` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `address` varchar(255) NOT NULL,
    `delivered` bool NOT NULL,
    `delivery_date` date NOT NULL,
    `delivery_time` time(6) NOT NULL,
    `order_id` bigint NOT NULL,
    `user_id` integer NOT NULL
);

ALTER TABLE
    `delivery_delivery`
ADD
    CONSTRAINT `delivery_delivery_order_id_8307ff51_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`);

ALTER TABLE
    `delivery_delivery`
ADD
    CONSTRAINT `delivery_delivery_user_id_569d0e2f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Create model Delivery
--
CREATE TABLE `delivery_delivery` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `address` varchar(255) NOT NULL,
    `delivered` bool NOT NULL,
    `delivery_date` date NOT NULL,
    `delivery_time` time(6) NOT NULL,
    `order_id` bigint NOT NULL,
    `user_id` integer NOT NULL
);

ALTER TABLE
    `delivery_delivery`
ADD
    CONSTRAINT `delivery_delivery_order_id_8307ff51_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`);

ALTER TABLE
    `delivery_delivery`
ADD
    CONSTRAINT `delivery_delivery_user_id_569d0e2f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);