
const fetch = require("node-fetch");
const moment = require("moment");
const noti = require("./notifier");
const options = {
  method: "get",
  headers: {
    "accept": "application/json",
    "Accept-Language": "hi_IN",
    "User-Agent":
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36",
  },
};


// for delay
async function sleep(millis) {
  return new Promise((resolve) => setTimeout(resolve, millis));
}

// find centers funtions
exports.findCenter = (data) => {
  const pincodeList = [];
  Object.entries(data).forEach(async ([pincode, cenetrIds]) => {
    const centId = [];
    Object.entries(cenetrIds).forEach(async ([id, value]) => {
      centId.push(id);
    });
    pincodeList.push({
      pincode: pincode,
      cIds: centId,
    });
  });
  console.log(pincodeList);
  getData(pincodeList);
};


// Grt data Request
async function getData(pincodeList) {
  for (pins in pincodeList) {
    // 100 request in 5 mins
    await sleep(3010);
    const fromList=pincodeList[pins];
    fetchRes(fromList.pincode, fromList.cIds);
  }
}


// API Phase
async function fetchRes(pincode, cenetrIds) {
  const today = moment();
  const dateString = today.format("DD-MM-YYYY");

  try {
    const res = await fetch(
        "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode=" +
      pincode +
      "&date=" +
      dateString,
        options,
    );
    const body = await res.json();
    const centers=body.centers;
    if (centers.length>0) {
      centers.forEach((center) => {
        if (cenetrIds.includes(`${center.center_id}`)) {
          const sessions = center.sessions;
          const validSlots = sessions.filter(
              (slot) => slot.available_capacity > 0,
          );
          // console.log({date:DATE, validSlots: validSlots.length})
          if (validSlots.length > 0) {
            console.log(center.name);

            // Notification with firebase
            noti.sendNotification(center.center_id, center.name, pincode);
          }
        }
      });
    }
  } catch (e) {
    console.log("Error Occured in API phase: "+e);
  }
}
