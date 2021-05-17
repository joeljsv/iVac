// private\vaine-notifier-firebase-adminsdk-gk4oa-c89472ff4f.json

var admin = require("firebase-admin");
const path = require("path");

var serviceAccount = path.join(__dirname, "service_key.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "<firebase-database-url>",
});
// Database Intialising
const db = admin.database();

const datetime = new Date();

// Notification manager
exports.sendNotification = (cenetrId, centerName, pincode) => {
  const ref = db.ref("/notify/" + pincode + "/" + cenetrId);
  ref.once("value", function (snapshot) {
    const dataFr = snapshot.val();

    // Takng Time Diffrence
    const lastTime = dataFr.lastNotify ?? datetime.toISOString();
    const timeDiff = timeDiffrence(lastTime, datetime);
    // Send Notification only after  7 hours
    if (timeDiff > 7 || !dataFr.lastNotify) {
      var payload = {
        notification: {
          title: "Vaccine avilable",
          body: centerName + " have avilable Slots",
        },
      };

      // Notification Is based On topic , center Id

      var topic = `${cenetrId}`;

      admin
        .messaging()
        .sendToTopic(topic, payload)
        .then(function (response) {
          console.log("Successfully sent message:", response);
        })
        .catch(function (error) {
          console.log("Error sending message:", error);
        });

      ref.update({
        lastNotify: datetime.toISOString(),
      });
    }
  });
};

// Time diffrence Calculator

function timeDiffrence(lastTime, dattimenow) {
  const parseDate = new Date(lastTime);
  let timeDifference =
    Math.abs(dattimenow.getTime() - parseDate.getTime()) / 1000;
  timeDifference /= 60 * 60;
  timeDifference = Math.round(timeDifference);

  return timeDifference;
}
