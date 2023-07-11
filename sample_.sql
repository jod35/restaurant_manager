
CREATE TABLE `django_migrations` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `app` varchar(255) NOT NULL, `name` varchar(255) NOT NULL, `applied` datetime(6) NOT 
NULL);

CREATE TABLE `django_content_type` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(100) NOT NULL, `app_label` varchar(100) NOT NULL, `model` varchar(100) NOT NULL); 

ALTER TABLE `django_content_type` ADD CONSTRAINT `django_content_type_app_label_model_76bd3d3b_uniq` UNIQUE (`app_label`, `model`); 



CREATE TABLE `auth_permission` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(50) NOT NULL, `content_type_id` integer 
NOT NULL, `codename` varchar(100) NOT NULL); 



CREATE TABLE `auth_group` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` 
varchar(80) NOT NULL UNIQUE); 

CREATE TABLE `auth_group_permissions` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `group_id` integer NOT NULL, `permission_id` integer NOT NULL);    


CREATE TABLE `auth_user` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `password` varchar(128) NOT NULL, `last_login` datetime(6) NOT NULL, `is_superuser` bool NOT NULL, `username` varchar(30) NOT NULL UNIQUE, `first_name` varchar(30) NOT NULL, `last_name` varchar(30) NOT NULL, `email` varchar(75) NOT NULL, `is_staff` bool NOT NULL, `is_active` bool NOT NULL, `date_joined` datetime(6) NOT NULL);    

CREATE TABLE `auth_user_groups` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `user_id` integer NOT NULL, `group_id` integer NOT NULL); 
CREATE TABLE `auth_user_user_permissions` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `user_id` integer NOT NULL, `permission_id` integer NOT NULL); 




ALTER TABLE `auth_permission` ADD CONSTRAINT `auth_permission_content_type_id_codename_01ab375a_uniq` UNIQUE (`content_type_id`, `codename`); 

ALTER TABLE `auth_permission` ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`); 
     
ALTER TABLE `auth_group_permissions` ADD CONSTRAINT `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` UNIQUE (`group_id`, `permission_id`); 

ALTER TABLE `auth_group_permissions` ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`); 

ALTER TABLE `auth_group_permissions` ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`); 

ALTER TABLE `auth_user_groups` ADD CONSTRAINT `auth_user_groups_user_id_group_id_94350c0c_uniq` UNIQUE (`user_id`, `group_id`); 
    


ALTER TABLE `auth_user_user_permissions` ADD CONSTRAINT `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` UNIQUE (`user_id`, `permission_id`); 

ALTER TABLE `auth_user_user_permissions` ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`); 

ALTER TABLE `auth_user_user_permissions` ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`); 



CREATE TABLE `django_admin_log` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `action_time` datetime(6) NOT NULL, `object_id` longtext NULL, `object_repr` varchar(200) NOT NULL, `action_flag` smallint UNSIGNED NOT NULL CHECK (`action_flag` >= 0), `change_message` longtext NOT NULL, `content_type_id` integer NULL, `user_id` integer NOT NULL); 
CREATE TABLE `django_admin_log` (`id` integer AUTO_INCREMENT NOT NULL PRIMARY KEY, `action_time` datetime(6) NOT NULL, `object_id` longtext NULL, `object_repr` 
varchar(200) NOT NULL, `action_flag` smallint UNSIGNED NOT NULL CHECK (`action_flag` >= 0), `change_message` longtext NOT NULL, `content_type_id` integer NULL, `user_id` integer NOT NULL); 








ALTER TABLE `django_admin_log` ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` 
(`id`); 
ALTER TABLE `django_admin_log` ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`); 
    
ALTER TABLE `django_admin_log` ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`); 

ALTER TABLE `django_content_type` MODIFY `name` varchar(100) NULL; 

ALTER TABLE `django_content_type` DROP COLUMN `name`; 

ALTER TABLE `auth_permission` MODIFY `name` varchar(255) NOT NULL; 

ALTER TABLE `auth_user` MODIFY `email` varchar(254) NOT NULL; 

ALTER TABLE `auth_user` MODIFY `last_login` datetime(6) NULL; 

ALTER TABLE `auth_user` MODIFY `username` varchar(150) NOT NULL; 

ALTER TABLE `auth_user` MODIFY `last_name` varchar(150) NOT NULL; 

ALTER TABLE `auth_group` MODIFY `name` varchar(150) NOT NULL; 

ALTER TABLE `auth_user` MODIFY `first_name` varchar(150) NOT NULL; 



CREATE TABLE `menu_menuitem` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `name` varchar(100) NOT NULL, `price` numeric(6, 2) NOT NULL); 

CREATE TABLE `order_order` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `created_at` datetime(6) NOT NULL); 

CREATE TABLE `order_orderitem` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `quantity` integer UNSIGNED NOT NULL CHECK (`quantity` >= 0), `created` datetime(6) NOT NULL, `item_id` bigint NOT NULL, `order_id` bigint NOT NULL);         


ALTER TABLE `order_order` ADD COLUMN `user_id` integer NOT NULL , ADD CONSTRAINT `order_order_user_id_7cf9bc2b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user`(`id`); 


ALTER TABLE `order_orderitem` ADD CONSTRAINT `order_orderitem_item_id_ade63ba0_fk_menu_menuitem_id` FOREIGN KEY (`item_id`) REFERENCES `menu_menuitem` (`id`); 




CREATE TABLE `delivery_delivery` (`id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY, `address` varchar(255) NOT NULL, `delivered` bool 
NOT NULL, `delivery_date` date NOT NULL, `delivery_time` time(6) NOT NULL, `order_id` bigint NOT NULL, `user_id` integer NOT NULL); 









ALTER TABLE `delivery_delivery` ADD CONSTRAINT `delivery_delivery_order_id_8307ff51_fk_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `order_order` (`id`); 
  
ALTER TABLE `delivery_delivery` ADD CONSTRAINT `delivery_delivery_user_id_569d0e2f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`); 




CREATE TABLE `reservation_reservation` (`id` bigint AUTO_INCREMENT NOT NULL 
PRIMARY KEY, `date` date NOT NULL, `time` time(6) NOT NULL, `guest_name` varchar(225) NOT NULL, `created` datetime(6) NOT NULL, `user_id` integer NOT NULL); 


ALTER TABLE `reservation_reservation` ADD CONSTRAINT `reservation_reservation_user_id_261c5876_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`); 



CREATE TABLE `django_session` (`session_key` varchar(40) NOT NULL PRIMARY KEY, `session_data` longtext NOT NULL, `expire_date` datetime(6) NOT NULL); 




CREATE INDEX `django_session_expire_date_a5c62663` ON `django_session` (`expire_date`); 
 









