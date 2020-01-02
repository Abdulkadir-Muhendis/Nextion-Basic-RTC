/*
 *******************************************************************
  Eng. Abdulkadir MÜHENDİS, M.Sc. Embedded Systems Arcitect
  Nextion Basic 3.5 inch with external RTC Module
  Version 1.0 2019
 *******************************************************************
*/
#include <Nextion.h>
#include <OneWire.h>
#include <string.h>
#include "Arduino.h"
#include "Wire.h"
#include "RTClib.h"
/*
 *******************************************************************
   Nextion component for page:home
 *******************************************************************
*/
NexText hour = NexText(0, 1, "hour");
NexText minute = NexText(0, 13, "minute");
NexText second = NexText(0, 14, "sec");
NexText month = NexText(0, 3, "mon");
NexText year = NexText(0, 4, "year2");
NexText week = NexText(0, 5, "week");
NexText day = NexText(0, 6, "day");
NexButton goset = NexButton(0, 2, "goset");
/*
 *******************************************************************
   Nextion component for page:set
 *******************************************************************
*/
NexButton backhome = NexButton(1, 1, "backhome");
NexButton settime = NexButton(1, 2, "settime");
/*
 *******************************************************************
   Nextion component for page:time
 *******************************************************************
*/
NexText sethour = NexText(2, 2, "sethour1");
NexText setmin = NexText(2, 3, "setmin1");
NexText setweek = NexText(2, 16, "setweek1");
NexText setday = NexText(2, 8, "setday1");
NexText setmon = NexText(2, 12, "setmon1");
NexText setyear = NexText(2, 13, "setyear2");
NexButton settime_add = NexButton(2, 5, "up0");
NexButton settime_dec = NexButton(2, 6, "down0");
NexButton settime_ok = NexButton(2, 7, "settimeok");
NexButton time_back_to_set = NexButton(2, 1, "backset1");
/*
 *******************************************************************
   Nextion component all page
 *******************************************************************
*/
NexPage home = NexPage(0, 0, "home");
NexPage set = NexPage(1, 0, "set");
NexPage time = NexPage(2, 0, "time");
NexTouch *nex_Listen_List[] =
{
  &settime,&backhome,&goset,
  &sethour, &setmin, &setweek, &setday, &setmon, &setyear,
  &settime_add, &settime_dec, &settime_ok, &time_back_to_set,
  NULL
};
RTCLib rtc;
/*
 *******************************************************************
  partial variables
 *******************************************************************
*/
uint32_t number = 0;
unsigned long update = 1;
int32_t timer = -1;          /* timer for second */
/*
 *******************************************************************
   Buffer zone of various variables
 *******************************************************************
*/
char buffer[10] = {0};
char buffer_temp[10] = {0};
char buffer_year[10] = {0};
char buffer_month[10] = {0};
char buffer_day[10] = {0};
char buffer_hour[10] = {0};
char buffer_minute[10] = {0};
char buffer_week[10] = {0};
uint8_t buffer_second = 0;
/*
 *******************************************************************
   TIME partial variable
 *******************************************************************
*/
int8_t settime_type = -1;
int8_t settime_up = -1;
int8_t number_settime_year = -1;
int8_t number_settime_month = -1;
int8_t number_settime_day = -1;
int8_t number_settime_hour = -1;
int8_t number_settime_minute = -1;
int32_t number_settime_week = -1;
/*
*******************************************************************
  TIME partial start
*******************************************************************
*/
void timePopCallback(void *ptr)
{
  time.show();
  setyear.setText(buffer_year);

  memset(buffer, 0, sizeof(buffer)); //To fill the array 
  number_settime_month = rtc.month();
  itoa(number_settime_month, buffer, 10); //itoa: to convert a number into a string
  setmon.setText(buffer);

  setday.setText(buffer_day);
  sethour.setText(buffer_hour);
  setmin.setText(buffer_minute);
  setweek.setText(buffer_week);
  number_settime_year = atoi(buffer_year); //atoi(): to convert string to a floating point value.
  number_settime_day = atoi(buffer_day);
  number_settime_hour = atoi(buffer_hour);
  number_settime_minute = atoi(buffer_minute);
  number_settime_week = rtc.dayOfWeek();
}

void timeOkPopCallback(void *ptr)
{
  rtc.set(0, number_settime_minute, number_settime_hour,
          number_settime_week, number_settime_day,
          number_settime_month, number_settime_year);
}

void timeAddPopCallback(void *ptr)
{
  settime_up = 1;
  setTime();
  setWeek();
}

void timeDECPopCallback(void *ptr)
{
  settime_up = 0;
  setTime();
  setWeek();
}

void setYearPopCallback(void *ptr)
{
  settime_type = 1;
}

void setMonPopCallback(void *ptr)
{
  settime_type = 2;
}

void setDayPopCallback(void *ptr)
{
  settime_type = 3;
}

void setHourPopCallback(void *ptr)
{
  settime_type = 4;
}

void setMinPopCallback(void *ptr)
{
  settime_type = 5;
}

void setWeekPopCallback(void *ptr)
{
  settime_type = 6;
}

void setTime()
{
  switch (settime_type)
  {
    case 1:
      if (settime_up == 1)
      {
        number_settime_year++;
        if (number_settime_year > 99)
        {
          number_settime_year = 10;
        }
        memset(buffer, 0, sizeof(buffer));
        itoa(number_settime_year, buffer, 10);
        setyear.setText(buffer);
      }
      else if (settime_up == 0)
      {
        number_settime_year--;
        if (number_settime_year < 10)
        {
          number_settime_year = 99;
        }
        memset(buffer, 0, sizeof(buffer));
        itoa(number_settime_year, buffer, 10);
        setyear.setText(buffer);
      }
      break;
    case 2:
      if (settime_up == 1)
      {
        number_settime_month++;
        if (number_settime_month > 12)
        {
          number_settime_month = 1;
        }
        memset(buffer, 0, sizeof(buffer));
        itoa(number_settime_month, buffer, 10);
        setmon.setText(buffer);
      }
      else if (settime_up == 0)
      {
        number_settime_month--;
        if (number_settime_month < 1)
        {
          number_settime_month = 12;
        }
        memset(buffer, 0, sizeof(buffer));
        itoa(number_settime_month, buffer, 10);
        setmon.setText(buffer);
      }
      break;
    case 3:
      {

        int8_t dayofmonth = number_settime_month;
        if (settime_up == 1)
        {
          number_settime_day++;
          if (dayofmonth == 1 || dayofmonth == 3 || dayofmonth == 5
              || dayofmonth == 7 || dayofmonth == 8 || dayofmonth == 10
              || dayofmonth == 12 )
          {
            if (number_settime_day > 31)
            {
              number_settime_day = 1;
            }
          }
          if (dayofmonth == 4 || dayofmonth == 6 || dayofmonth == 9
              || dayofmonth == 11)
          {
            if (number_settime_day > 30)
            {
              number_settime_day = 1;
            }
          }
          if (dayofmonth == 2)
          {
            if ((number_settime_year % 4 == 0 && number_settime_year % 100 != 0) || number_settime_year % 400 == 0)
            {
              if (number_settime_day > 29)
              {
                number_settime_day = 1;
              }
            }
            else
            {
              if (number_settime_day > 28)
              {
                number_settime_day = 1;
              }
            }
          }
          memset(buffer, 0, sizeof(buffer));
          itoa(number_settime_day, buffer, 10);
          setday.setText(buffer);
        }
        else if (settime_up == 0)
        {
          number_settime_day--;
          if (dayofmonth == 1 || dayofmonth == 3 || dayofmonth == 5
              || dayofmonth == 7 || dayofmonth == 8 || dayofmonth == 10
              || dayofmonth == 12 )
          {
            if (number_settime_day < 1)
            {
              number_settime_day = 31;
            }
          }
          if (dayofmonth == 4 || dayofmonth == 6 || dayofmonth == 9
              || dayofmonth == 11)
          {
            if (number_settime_day < 1)
            {
              number_settime_day = 30;
            }
          }
          if (dayofmonth == 2)
          {
            if ((number_settime_year % 4 == 0 && number_settime_year % 100 != 0) || number_settime_year % 400 == 0)
            {
              if (number_settime_day < 1)
              {
                number_settime_day = 29;
              }
            }
            else
            {
              if (number_settime_day < 1)
              {
                number_settime_day = 28;
              }
            }
          }
          memset(buffer, 0, sizeof(buffer));
          itoa(number_settime_day, buffer, 10);
          setday.setText(buffer);
        }
        break;
      }
    case 4:
      if (settime_up == 1)
      {
        number_settime_hour++;
        if (number_settime_hour > 23)
        {
          number_settime_hour = 0;
        }
        memset(buffer, 0, sizeof(buffer));
        itoa(number_settime_hour, buffer, 10);
        sethour.setText(buffer);
      }
      else if (settime_up == 0)
      {
        number_settime_hour--;
        if (number_settime_hour < 0)
        {
          number_settime_hour = 23;
        }
        memset(buffer, 0, sizeof(buffer));
        itoa(number_settime_hour, buffer, 10);
        sethour.setText(buffer);
      }
      break;
    case 5:
      if (settime_up == 1)
      {
        number_settime_minute++;
        if (number_settime_minute > 59)
        {
          number_settime_minute = 0;
        }
        memset(buffer, 0, sizeof(buffer));
        itoa(number_settime_minute, buffer, 10);
        setmin.setText(buffer);
      }
      else if (settime_up == 0)
      {
        number_settime_minute--;
        if (number_settime_minute < 0)
        {
          number_settime_minute = 59;
        }
        memset(buffer, 0, sizeof(buffer));
        itoa(number_settime_minute, buffer, 10);
        setmin.setText(buffer);
      }
      break;
  }
}

void setWeek(void)
{
  int32_t year;
  int32_t month;
  if (number_settime_month < 3)
  {
    month = number_settime_month + 12;
    year = number_settime_year - 1;
  }
  else
  {
    month = number_settime_month;
    year = number_settime_year;
  }

  number_settime_week = year + year / 4 + 20 / 4 - 2 * 20 + ((26 * (month + 1)) / 10 + number_settime_day - 1);
  number_settime_week = (number_settime_week % 7 + 7) % 7 + 1;
  switch (number_settime_week)
  {
    case 1:
      strcpy(buffer, "Sunday");
      break;
    case 2:
      strcpy(buffer, "Monday");
      break;
    case 3:
      strcpy(buffer, "Tuesday");
      break;
    case 4:
      strcpy(buffer, "Wednesday");
      break;
    case 5:
      strcpy(buffer, "Thursday");
      break;
    case 6:
      strcpy(buffer, "Friday");
      break;
    case 7:
      strcpy(buffer, "Saturday");
      break;
    default:
      strcpy(buffer, "fail");
      break;
  }
  setweek.setText(buffer);
}

void timeToSetPopCallback(void *ptr)
{
  set.show();
}
/*
*******************************************************************
  TIME partial end
*******************************************************************
*/
void backHomePopCallback(void *ptr)
{
  home.show();
  refreshHome();
}

void  refreshHome(void)
{
  year.setText(buffer_year);
  month.setText(buffer_month);
  day.setText(buffer_day);
  hour.setText(buffer_hour);
  minute.setText(buffer_minute);
  week.setText(buffer_week);
}

void goSetPopCallback(void *ptr)
{
  Serial.println("RRR");
  set.show();
}

void timeDisplay(void)
{
  memset(buffer, 0, sizeof(buffer));
  number = rtc.hour();
  itoa(number, buffer, 10);
  if (strcmp(buffer_hour, buffer))
  {
    hour.setText(buffer);
    strcpy(buffer_hour, buffer);
  }

  memset(buffer, 0, sizeof(buffer));
  memset(buffer_temp, 0, sizeof(buffer_temp));
  number = rtc.minute();
  itoa(number, buffer_temp, 10);
  if (rtc.minute() < 10)
  {
    strcat(buffer, "0");
  }
  strcat(buffer, buffer_temp);
  if (strcmp(buffer_minute, buffer))
  {
    minute.setText(buffer);
    strcpy(buffer_minute, buffer);
  }

  memset(buffer, 0, sizeof(buffer));
  memset(buffer_temp, 0, sizeof(buffer_temp));
  number = rtc.second();
  if (number != buffer_second)
  {
    timer++;
    if (number % 2)
    {
      strcpy(buffer, ":");
      second.setText(buffer);
      buffer_second = number;
    }
    else
    {
      strcpy(buffer, " ");
      second.setText(buffer);
      buffer_second = number;
    }
  }
  switch (rtc.dayOfWeek())
  {
    case 1:
      strcpy(buffer, "Sunday");
      break;
    case 2:
      strcpy(buffer, "Monday");
      break;
    case 3:
      strcpy(buffer, "Tuesday");
      break;
    case 4:
      strcpy(buffer, "Wednesday");
      break;
    case 5:
      strcpy(buffer, "Thursday");
      break;
    case 6:
      strcpy(buffer, "Friday");
      break;
    case 7:
      strcpy(buffer, "Saturday");
      break;
    default:
      strcpy(buffer, "fail");
      break;
  }

  if (strcmp(buffer_week, buffer))
  {
    week.setText(buffer);
    strcpy(buffer_week, buffer);
  }

  memset(buffer, 0, sizeof(buffer));
  memset(buffer_temp, 0, sizeof(buffer_temp));
  number = rtc.year();
  itoa(number, buffer, 10);
  if (strcmp(buffer_year, buffer))
  {
    year.setText(buffer);
    strcpy(buffer_year, buffer);
  }

  switch (rtc.month())
  {
    case 1:
      strcpy(buffer, "Jan.");
      break;
    case 2:
      strcpy(buffer, "Feb.");
      break;
    case 3:
      strcpy(buffer, "Mar.");
      break;
    case 4:
      strcpy(buffer, "Apr.");
      break;
    case 5:
      strcpy(buffer, "May.");
      break;
    case 6:
      strcpy(buffer, "Jun.");
      break;
    case 7:
      strcpy(buffer, "Jul.");
      break;
    case 8:
      strcpy(buffer, "Aug.");
      break;
    case 9:
      strcpy(buffer, "Sep.");
      break;
    case 10:
      strcpy(buffer, "Oct.");
      break;
    case 11:
      strcpy(buffer, "Nov.");
      break;
    case 12:
      strcpy(buffer, "Dec.");
      break;
    default:
      strcpy(buffer, "fail");
      break;
  }
  if (strcmp(buffer_month, buffer))
  {
    month.setText(buffer);
    strcpy(buffer_month, buffer);
  }

  memset(buffer, 0, sizeof(buffer));
  number = rtc.day();
  itoa(number, buffer, 10);
  if (strcmp(buffer_day, buffer))
  {
    day.setText(buffer);
    strcpy(buffer_day, buffer);
  }
}
void setup(void)
{
  nexInit();
  Serial.begin(115200);
  Serial.println("Start");
  goset.attachPop(goSetPopCallback);
  backhome.attachPop(backHomePopCallback);
  settime.attachPop(timePopCallback);
  settime_ok.attachPop(timeOkPopCallback);
  settime_add.attachPop(timeAddPopCallback);
  settime_dec.attachPop(timeDECPopCallback);
  setyear.attachPop(setYearPopCallback);
  setmon.attachPop(setMonPopCallback);
  setday.attachPop(setDayPopCallback);
  sethour.attachPop(setHourPopCallback);
  setmin.attachPop(setMinPopCallback);
  setweek.attachPop(setWeekPopCallback);
  time_back_to_set.attachPop(timeToSetPopCallback);
  Serial.println("Start3");
  timer = millis();
  /* RTClib::set(byte second, byte minute, byte hour,
     byte dayOfWeek, byte dayOfMonth, byte month, byte year);
  */
  /*rtc.set(0, 5, 16, 3, 15, 2, 16);*/
}

void loop(void)
{
  if (millis() > update+ 5000)
  {
    update = millis();
  }
  rtc.refresh();
  timeDisplay();

  nexLoop(nex_Listen_List);
}
