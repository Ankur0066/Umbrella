const Joi = require('joi');

module.exports.listingSchema = Joi.object({
    listing: Joi.object({       
        image: Joi.string().allow("", null)
    }).required()
});