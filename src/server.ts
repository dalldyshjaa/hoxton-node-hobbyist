import { PrismaClient } from "@prisma/client";
import cors from "cors";
import express from "express";

const app = express();
app.use(cors());
app.use(express.json());
const prisma = new PrismaClient({ log: ["warn", "error", "info", "query"] });

const port = 3000;

app.get("/users", async (req, res) => {
  const users = await prisma.user.findMany({ include: { hobies: true } });

  res.send(users);
});

app.post("/users", async (req, res) => {
  let hobies = req.body.hobies ? req.body.hobies : [];
  const newUser = await prisma.user.create({
    data: {
      fullName: req.body.fullName,
      photoUrl: req.body.photoUrl,
      email: req.body.email,
      hobies: {
        // @ts-ignore
        connectOrCreate: hobies.map((hoby) => ({
          where: {
            name: hoby,
          },
          create: {
            name: hoby,
          },
        })),
      },
    },

    include: { hobies: true },
  });
  res.send(newUser);
});

app.get("/users/:id", async (req, res) => {
  const user = await prisma.user.findUnique({
    where: { id: Number(req.params.id) },
    include: { hobies: true },
  });
  res.send(user);
});

app.delete("/users/:id", async (req, res) => {
  const deletedUser = await prisma.user.delete({
    where: { id: Number(req.params.id) },
  });
  res.send(deletedUser);
});

app.patch("/users/:id", async (req, res) => {
  const updatedUser = await prisma.user.update({
    where: { id: Number(req.params.id) },
    data: req.body,
    include: { hobies: true },
  });
  res.send(updatedUser);
});

app.get("/hobies", async (req, res) => {
  //@ts-ignore
  const hobies = await prisma.hoby.findMany({ include: { users: true } });
  res.send(hobies);
});

app.get("/hobies/:id", async (req, res) => {
  const hoby = await prisma.hoby.findUnique({
    where: { id: Number(req.params.id) },
    //@ts-ignore
    include: { users: true },
  });
  res.send(hoby);
});

app.post("/hobies", async (req, res) => {
  const newHoby = await prisma.hoby.create({
    data: req.body,
    //@ts-ignore
    include: { users: true },
  });
  res.send(newHoby);
});

app.patch("/hobies/:id", async (req, res) => {
  const updatedHoby = await prisma.hoby.update({
    where: { id: Number(req.params.id) },
    data: req.body,
    //@ts-ignore
    include: { users: true },
  });
  res.send(updatedHoby);
});

app.delete("/hobies/:id", async (req, res) => {
  const deletedHoby = await prisma.hoby.delete({
    where: { id: Number(req.params.id) },
  });
  res.send(deletedHoby);
});

app.listen(port, () => {
  console.log("What?");
});
