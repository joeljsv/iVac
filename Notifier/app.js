

const firebase = require("firebase");


const findCenter = require("./cenetrfinder");

const firConfig = {
  // Firebase 
};

firebase.initializeApp(firConfig);

const db = firebase.database();
const ref = db.ref("/notify");
console.log("Started");

 intervalFunc();

//  runs every 16 minutes
  // setInterval(intervalFunc, 1014000);


function intervalFunc() {
 
  ref.once("value").then((val) => {
    const data = val.val();
    // console.log(data);
    findCenter.findCenter(data);
  });
}
