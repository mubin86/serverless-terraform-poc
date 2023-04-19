const dynamoose = require("dynamoose");
const path = require("path")
require('dotenv').config({path: path.resolve(__dirname, '../../nodejs/.env')})
const PocGameTableName = process.env.POC_GAME_TABLE;

const PocGameSchema = new dynamoose.Schema(
    {
        AccountId: {
            type: String,
            hashKey: true,
            required: true,
            index: {
                name: "ScoreIndex",
                // type: "local",
                rangeKey: "Score",
            }
        },
        CreatedAt: {
            type: Date,
            required: true,
            rangeKey: true
        },
        OriginCountry: {
            type: String,
            required: true
        },
        GameTitle: {
            type: String,
            required: true,
            trim: true,
            index: {
                name: "GameTitleIndex",
                type: "global",
                global: true,
                rangeKey: "OriginCountry",
            }
        },
        Score: {
            type: Number,
            required: true,
            // index: true, ->this indicates the LSI
        }
    },
    // {
    //     timestamps: {
    //         "createdAt": ["createDate", "CreatedAt"],
    //         "updatedAt": ["updateDate", "UpdatedAt"]
    //     }
    // }
);

const PocGame = dynamoose.model(process.env.POC_GAME_TABLE, PocGameSchema, {
    "create": false,
    "waitForActive": false
});

// module.exports = PocGame;
exports.PocGame = PocGame;