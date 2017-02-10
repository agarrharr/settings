#!/usr/bin/env /usr/local/bin/node

// <bitbar.title>Clock and Calendar</bitbar.title>
// <bitbar.version>v1.0</bitbar.version>
// <bitbar.author>Adam Harris</bitbar.author>
// <bitbar.author.github>aharris88</bitbar.author.github>
// <bitbar.desc>Clock and calendar. It has an option for 24 hour time.</bitbar.desc>
// <bitbar.dependencies>node.js</bitbar.dependencies>

const ncp = require('./clockAndCalendar/node_modules/copy-paste');

const options = {
  notation: '24',
};

const months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
const RED = '\033[0;31m';
const YELLOW = '\033[0;33m';
const NC = '\033[0m';
const linkFilter = `font=AndaleMono href=https://calendar.google.com/`;
const fontFilter = `font=AndaleMono`;
const trimFilter = `trim=false`;

const now = new Date();

const daysInMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0).getDate();
const numberOfDigits = (a) =>  Math.floor(Math.log10(a)) + 1;
const padLeft = (a) => numberOfDigits(a) === 2 ? a : `0${a}`;

let hour;
let minutes;
if (options.notation === '24') {
  hour = padLeft(now.getHours());
  minutes = padLeft(now.getMinutes());
} else {
  hour = now.getHours();
  minutes = now.getMinutes();
}

const day = now.getDate();
const paddedDay = padLeft(now.getDate());
const month = padLeft(now.getMonth() + 1);
const monthName = months[now.getMonth()];
const year = now.getFullYear();

const firstDayOfWeek = new Date(now.getFullYear(), now.getMonth(), 1).getDay();

console.log(`${hour}:${minutes}`);
console.log(`---`);
console.log(`  ${monthName}| ${fontFilter} ${linkFilter} ${trimFilter}`);
console.log(`  S  M  T  W  T  F  S| ${fontFilter} ${linkFilter} ${trimFilter}`);

let daysSoFar = 0;
let currentWeekString = ``;
for(let i = 1; i <= daysInMonth; i += 1) {
  if (i === 1) {
    currentWeekString = ' '.repeat(firstDayOfWeek * 2 + firstDayOfWeek);
  }
  const extraSpace = numberOfDigits(i) === 1 ? ' ' : '';
  currentWeekString += day === i ? RED : '';
  currentWeekString += `${extraSpace} ${i}`;
  currentWeekString += day === i ? NC : '';
  if ((i + firstDayOfWeek) % 7 === 0 || i === daysInMonth) {
    console.log(`${currentWeekString}|${fontFilter} ${linkFilter} ${trimFilter}`);
    currentWeekString = '';
  }
}

const fullDate = `${year}-${month}-${paddedDay}`;
console.log(`${fullDate}| ${fontFilter} bash='echo' param1="${fullDate} | pbcopy" terminal=true`);
