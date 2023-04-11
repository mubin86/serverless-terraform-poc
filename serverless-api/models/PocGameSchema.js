import * as dynamoose from 'dynamoose';

export const PocGameSchema = new dynamoose.Schema(
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
            // index: true,
        }
    },
    // {
    //     timestamps: {
    //         "createdAt": ["createDate", "CreatedAt"],
    //         "updatedAt": ["updateDate", "UpdatedAt"]
    //     }
    // }
);

export const PocGame = dynamoose.model(process.env.POC_GAME_TABLE, PocGameSchema)