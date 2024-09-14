const mongoose = require('mongoose');
const { Schema } = mongoose;
const review = require("./reviews.js")
const User = require("../models/user.js");
const { string } = require('joi');
const listingschema = new Schema ({
image:{
    url:String,
    filename:String
}
})
module.exports = umbrella