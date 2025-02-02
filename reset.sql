-- Schema
DROP TABLE IF EXISTS user_account CASCADE;
DROP TABLE IF EXISTS restaurant CASCADE;
DROP TABLE IF EXISTS restaurant_owner CASCADE;
DROP TABLE IF EXISTS restaurant_admin CASCADE;
DROP TABLE IF EXISTS table_info CASCADE;
DROP TABLE IF EXISTS reservation CASCADE;
DROP TYPE IF EXISTS reservation_approval_status;

-- USER
DROP PROCEDURE IF EXISTS register_user;
DROP FUNCTION IF EXISTS checkpassword;

-- RESTAURANT
DROP FUNCTION IF EXISTS get_restaurant_list;
DROP PROCEDURE IF EXISTS create_restaurant;
DROP PROCEDURE IF EXISTS add_restaurant_admin_by_id;
DROP PROCEDURE IF EXISTS add_restaurant_admin_by_name_location;
DROP PROCEDURE IF EXISTS valid_owner_chkerr;
DROP PROCEDURE IF EXISTS valid_admin_chkerr;

-- TABLE
DROP PROCEDURE IF EXISTS add_restaurant_table;

-- RESERVATION
DROP PROCEDURE IF EXISTS reserve_table;