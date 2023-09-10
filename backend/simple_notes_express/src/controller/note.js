const pool = require('../config/database');

const getAllNote = (req, res) => {
    pool.query('SELECT * FROM simple_notes order by id DESC', (error, results) => {
      if (error) {
        res.status(500).json({
            message: 'Server Error',
            serverMessage: error.message,
        })
      } else {
        res.json({
          note: results.rows
        })
      }
    })
}

const findById = (req, res) => {
    const {id} = req.params;
    pool.query('SELECT * FROM simple_notes WHERE id = $1', [id], (error, results) => {
      if (error) {
        res.status(500).json({
            message: 'Server Error',
            serverMessage: error.message,
        })
      } else {
        res.json({
          note: results.rows
        })
      }
    })
}

const addNewNote = (req, res) => {
    const {body} = req;

    if(body.note) {
        pool.query('INSERT INTO simple_notes (title, note) VALUES ($1, $2)', 
                [body.title, body.note], (error, results) => {
            if (error) {
                res.status(500).json({
                    message: 'Server Error',
                    serverMessage: error.message,
                })
            } else {
                res.status(201).json({message: 'Add note success'})
            }
        })
    }
}

const updateNote = (req, res) => {
    const {id} = req.params;
    const {body} = req;

    pool.query('UPDATE simple_notes SET title = $1, note = $2 WHERE id = $3', [body.title, body.note, id], (error, results) => {
        if (error) {
            res.status(500).json({
                message: 'Server Error',
                serverMessage: error.message,
            })
        } else {
            res.status(200).json({message: 'Update note success'})
        }
    })
}

const deleteNote = (req, res) => {
    const {id} = req.params;

    pool.query('DELETE FROM simple_notes WHERE id = $1', [id], (error, results) => {
        if (error) {
            res.status(500).json({
                message: 'Server Error',
                serverMessage: error.message,
            })
        } else {
            res.status(200).json({message: 'Delete note success'})
        }
    })

}

module.exports = {
    getAllNote,
    findById,
    addNewNote,
    updateNote,
    deleteNote
}
