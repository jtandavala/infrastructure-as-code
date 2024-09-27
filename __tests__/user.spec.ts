const request = require("supertest");
const app = require("../server");

describe("Users CRUD API", () => {
  let userId;

  it("should create a new user", async () => {
    const res = await request(app).post("/users").send({
      id: 1,
      name: "John Doe",
      email: "john@example.com",
    });
    expect(res.statusCode).toEqual(201);
    expect(res.body).toHaveProperty("id");
    userId = res.body.id;
  });

  it("should get all users", async () => {
    const res = await request(app).get("/users");
    expect(res.statusCode).toEqual(200);
    expect(Array.isArray(res.body)).toBeTruthy();
  });

  it("should get a user by ID", async () => {
    const res = await request(app).get(`/users/${userId}`);
    expect(res.statusCode).toEqual(200);
  });

  it("should update a user", async () => {
    const res = await request(app).put(`/users/${userId}`).send({
      name: "Jane Doe",
      email: "jane@example.com",
    });
    expect(res.statusCode).toEqual(200);
    expect(res.body).toHaveProperty("name", "Jane Doe");
  });

  it("should delete a user", async () => {
    const res = await request(app).delete(`/users/${userId}`);
    expect(res.statusCode).toEqual(204);
  });

  it("should return 404 for non-existing user", async () => {
    const res = await request(app).get(`/users/${userId}`);
    expect(res.statusCode).toEqual(404);
  });
});
