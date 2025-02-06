use("project");

db.user.deleteMany({});
db.restaurant.deleteMany({});
db.reservation.deleteMany({});

db.user.insertMany([
  {
    firstname: "Adam",
    lastname: "Smith",
    phone: "033-1009001",
    email: "test1@email.com",
    password: "adamcool",
    restaurant_owner: [1, 2],
  },
  {
    firstname: "David",
    lastname: "Ricardo",
    phone: "033-1009002",
    email: "test2@email.com",
    password: "davidcool",
    restaurant_admin: [1, 2],
  },
  {
    firstname: "John",
    lastname: "Keynes",
    phone: "033-1009003",
    email: "test3@email.com",
    password: "johncool",
    restaurant_admin: [3],
  },
  {
    firstname: "Joe",
    lastname: "Dart",
    phone: "033-1009004",
    email: "test4@email.com",
    password: "joecool",
    restaurant_owner: [3],
  },
  {
    firstname: "Jake",
    lastname: "Li",
    phone: "033-1009005",
    email: "test5@email.com",
    password: "jakecool",
  },
]);

db.restaurant.insertMany([
  {
    restaurant_id: 1,
    name: "MACROEAT",
    location: "Engineering Faculty, Chula",
    phone: "077-1000123",
    open_time: "08:00:00",
    close_time: "16:00:00",
    owner_email: "test1@email.com",
    admin: ["test2@email.com"],
    table: [
      { code: "2S1", capacity: 2, average_time: 20 },
      { code: "2S2", capacity: 2, average_time: 20 },
      { code: "4S1", capacity: 4, average_time: 35 },
    ],
  },
  {
    restaurant_id: 2,
    name: "Classic Chips",
    location: "Engineering Faculty, Chula",
    phone: "077-1000124",
    open_time: "08:00:00",
    close_time: "17:00:00",
    owner_email: "test1@email.com",
    admin: ["test2@email.com"],
    table: [{ code: "1S1", capacity: 1, average_time: 15 }],
  },
  {
    restaurant_id: 3,
    name: "Test",
    location: "Engineering Faculty, Chula",
    phone: "077-1000125",
    open_time: "04:00:00",
    close_time: "22:00:00",
    owner_email: "test4@email.com",
    admin: ["test3@email.com"],
  },
]);

db.reservation.insertMany([
  {
    user_email: "test1@email.com",
    restaurant_id: 1,
    table_code: "2S1",
    reserve_time: new Date("2025-10-20 17:00:00"),
    approval_status: "pending",
    payment_status: false,
    reserved_on: new Date(),
  },
]);
