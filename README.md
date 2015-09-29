### Programming Assignment:

Web endpoint for a treasure hunt game.
It allows participants to send requests to an endpoint, containing their current position (latitude and longitude in decimal representation) and email. Response contains a distance to the treasure expressed in meters. When players are in a 5 meter radius from the treasure an e-mail message with congratulations and exact position of the treasure is sent on the provided e-mail address.
Congratulations email is sent only once. 

#### Treasure location:
`50.051227 N, 19.945704 E`

#### Request format: 
`/treasure_hunt.json?current_location[]=:latitude&current_location[]=:longitude&email=:email`

#### Example request:
`POST /treasure_hunt.json?current_location[]=0&current_location[]=0&email=test@example.com`

#### Example response:
Successful response:
```
{ status: 'ok', distance: 10 }
```
Error response:
```
{ status: 'error', distance: -1, error: 'error description' }
```

#### Email Content: 
“Hey, you’ve found a treasure, congratulations!
You are [:nth] treasure hunter who has found the treasure.” Replace [:nth] with the actual number of treasure hunters who successfully found a treasure before + 1.”

#### Contains:
* unit and functional tests
* auth token - based authentication for API requests
* dashboard visualizing points sent by users on a map (http://treasure-hunting.herokuapp.com/)
