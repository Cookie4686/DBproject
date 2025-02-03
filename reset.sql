-- Schema
DROP TABLE IF EXISTS user_account CASCADE;
DROP TABLE IF EXISTS restaurant CASCADE;
DROP TABLE IF EXISTS restaurant_admin CASCADE;
DROP TABLE IF EXISTS table_info CASCADE;
DROP TABLE IF EXISTS reservation CASCADE;

-- USER
DROP PROCEDURE IF EXISTS register_user;
DROP FUNCTION IF EXISTS checkpassword;

-- RESTAURANT
DROP FUNCTION IF EXISTS get_restaurant;
DROP PROCEDURE IF EXISTS create_restaurant;
DROP PROCEDURE IF EXISTS add_restaurant_admin_by_id;
DROP PROCEDURE IF EXISTS add_restaurant_admin_by_name_location;
DROP FUNCTION IF EXISTS get_restaurant_id;
DROP PROCEDURE IF EXISTS valid_owner_chkerr;
DROP PROCEDURE IF EXISTS valid_admin_chkerr;

-- TABLE
DROP PROCEDURE IF EXISTS create_table_by_id;
DROP PROCEDURE IF EXISTS create_table_by_name_location;

-- RESERVATION
DROP FUNCTION IF EXISTS get_available_restaurant;
DROP FUNCTION IF EXISTS get_user_reservation;
DROP PROCEDURE IF EXISTS reserve_table;
DROP FUNCTION IF EXISTS get_restaurant_reservation;
DROP PROCEDURE IF EXISTS edit_restaurant_reservation;
DROP FUNCTION IF EXISTS get_available_restaurant_table;
DROP FUNCTION IF EXISTS is_restaurant_available;
DROP FUNCTION IF EXISTS is_table_available;

-- SCHEMA TYPE
DROP TYPE IF EXISTS reservation_approval_status;