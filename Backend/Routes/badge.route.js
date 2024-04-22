const express = require('express');
const router = express.Router();
const Badge = require('../models/Badge');

// Get all badges
router.get('/', async (req, res) => {
    try {
        const badges = await Badge.find();
        res.json(badges);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

// Add a badge
router.post('/', async (req, res) => {
    const badge = new Badge({
        name: req.body.name,
        description: req.body.description,
    });

    try {
        const newBadge = await badge.save();
        res.status(201).json(newBadge);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

module.exports = router;
