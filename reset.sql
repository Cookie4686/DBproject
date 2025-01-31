DROP TABLE IF EXISTS user_account CASCADE;
DROP TABLE IF EXISTS restaurant CASCADE;
DROP TABLE IF EXISTS restaurant_admin CASCADE;
DROP TABLE IF EXISTS table_info CASCADE;
DROP TABLE IF EXISTS reservation CASCADE;

DROP TYPE IF EXISTS reservation_approval_status;

DROP PROCEDURE add_restaurant_admin;
DROP PROCEDURE add_restaurant_table;
DROP PROCEDURE check_admin;
DROP FUNCTION checkpassword;
DROP PROCEDURE create_restaurant;
DROP FUNCTION get_restaurant_list;
DROP PROCEDURE register_user;
DROP PROCEDURE valid_admin_chkerr;
