import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart'; //the package for the calendar widget
import 'main.dart';

void main() {
  runApp(MyApp());
}


class Calendar extends StatelessWidget {
  // This widget is the root of my Calendar screen.
  @override
  Widget build(BuildContext context) {//the calendar widget is added as a child of the scaffold widget.
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        backgroundColor: Colors.green,),
        body: SfCalendar(
          view: CalendarView.schedule, //The SfCalendar widget provides seven different types of views to display dates.
          scheduleViewSettings: ScheduleViewSettings(//I have chosen the schedule view
            monthHeaderSettings: MonthHeaderSettings(
              backgroundColor: Color(0XFFF1F8E9),
              monthTextStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
              color: Color(0xFF878787),
            ),
            )
          ),
          todayHighlightColor: Colors.green,
          dataSource: MeetingDataSource(_getDataSource()),//Used to set the Appointment through the
                                                         // CalendarDataSource class.
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ),
    );
  }

  List<Meeting> _getDataSource() { //this adds a 'Meeting' to the calendar
    List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now(); //add the 'Meeting' to today's date on the calendar
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(Duration(hours: 2));
    meetings.add( //adds the 'Meeting' name, so I've put 'Plant artichokes'
        Meeting("Plant artichokes", startTime, endTime, Color(0xFF0F8644), false));
    return meetings; //adds plant time to calendar
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {// Maps the custom appointments start time zone to the Meeting.
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {//Maps the custom appointments end time zone to the Meeting.
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {//Maps the custom appointments subject to the Meeting.
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {//Maps the custom appointments color to the Meeting.
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {//Maps the custom appointments isAllDay to the Meeting
    return appointments[index].isAllDay;
  }
}

class Meeting {//the meeting which all methods from MeetingDataSource is mapped to
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName; //the name of the Meeting that will be added to Calendar
  DateTime from;//The time it will start
  DateTime to;//The time it will end
  Color background;//the colour for the event on the calendar
  bool isAllDay;//if the event is all day, isAllDay = True
}

