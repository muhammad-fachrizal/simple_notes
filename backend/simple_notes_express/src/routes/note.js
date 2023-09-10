const express = require('express');

const NoteController = require('../controller/note');

// instantiate a router (miniature version of the app object, capable of doing all the same things that the app object does)
const router = express.Router();

router.get("/example/", (req, res) => {
    res.send("This is an example of how to use a separate file in express");
  });

// CREATE - POST
router.post('/add', NoteController.addNewNote);

// READ - GET 
router.get('/', NoteController.getAllNote);

// READ - GET - findById
router.get('/find/:id', NoteController.findById);

// UPDATE - PATCH
router.patch('/update/:id', NoteController.updateNote);

// DELETE - DELETE
router.delete('/delete/:id', NoteController.deleteNote);

module.exports = router;