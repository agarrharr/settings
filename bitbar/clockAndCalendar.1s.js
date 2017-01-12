#!/usr/bin/env /usr/local/bin/node

// <bitbar.title>Clock and Calendar</bitbar.title>
// <bitbar.version>v1.0</bitbar.version>
// <bitbar.author>Adam Harris</bitbar.author>
// <bitbar.author.github>aharris88</bitbar.author.github>
// <bitbar.desc>Clock and calendar. It has an option for 24 hour time.</bitbar.desc>
// <bitbar.dependencies>node.js</bitbar.dependencies>

const options = {
  notation: '24',
};

const months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
const RED = '\033[0;31m';
const YELLOW = '\033[0;33m';
const NC = '\033[0m';
const filters = `trim=false font=AndaleMono href=https://calendar.google.com/`;

const now = new Date();
let hour = now.getHours();
let minutes = now.getMinutes();
const day = now.getDate();
const month = months[now.getMonth()];
const firstDayOfWeek = new Date(now.getFullYear(), now.getMonth(), 1).getDay();
const daysInMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0).getDate();

const numberOfDigits = (a) =>  Math.floor(Math.log10(a)) + 1;

if (options.notation === '24') {
  const hourDigits = numberOfDigits(hour);
  const minuteDigits = numberOfDigits(minutes);
  hour = hourDigits === 2 ? hour : `0` + hour;
  minutes = minuteDigits === 2 ? minutes : `0` + minutes;
}

console.log(`${hour}:${minutes}`);
console.log(`---`);
console.log(`  ${month}| ${filters}`);
console.log(`  S  M  T  W  T  F  S| ${filters}`);

let daysSoFar = 0;
let currentWeekString = ``;
for(let i = 1; i <= daysInMonth; i += 1) {
  if (i === 0) {
    currentWeekString = ' '.repeat(firstDayOfWeek * 2);
  }
  const extraSpace = numberOfDigits(i) === 1 ? ' ' : '';
  currentWeekString += day === i ? RED : '';
  currentWeekString += `${extraSpace} ${i}`;
  currentWeekString += day === i ? NC : '';
  if ((i) % 7 === 0 || i === daysInMonth) {
    console.log(`${currentWeekString}|${filters}`);
    currentWeekString = '';
  }
}
