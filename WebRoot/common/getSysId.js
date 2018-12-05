//获取sysid
function getSysId(char) {
    var date= new Date();
    var timestamp = Date.parse(date);
    timestamp = timestamp / 1000;
    return char+date.getFullYear()+timestamp;
}

function getYmd(char) {
    var date= new Date();
    var month=date.getMonth()+1;
    var day =date.getDate();
    var timestamp = Date.parse(date);
    timestamp = timestamp / 1000;
    return char+date.getFullYear()+month+day+timestamp;
}
