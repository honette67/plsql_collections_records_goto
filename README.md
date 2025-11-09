# PL/SQL Collections, Records, and GOTO Statements Project
_____________________________________________________________

Name: Honette Igiraneza
Id: 27707
Course: Database Development with PL/SQL 
Project title: Employee Attendance Tracker
# Problem Definition

A company wants to monitor the attendance of its employees for a week.
Each employee has:
-An Employee ID
-A Name
-A Collection (array) of attendance status for 7 days (e.g. 1 = Present, 0 = Absent)

The program should:
-Use a Record to store each employee’s details.
-Use a Collection (VARRAY) to store 7 attendance values.
-Calculate how many days the employee was present.
-Use a GOTO statement to skip processing if data is incomplete (e.g. less than 7 entries).
# Step-by-Step PL/SQL Code
SET SERVEROUTPUT ON;
DECLARE
  -- Step 1: Create a VARRAY type for attendance (7 days)
  TYPE AttendanceArray IS VARRAY(7) OF NUMBER;

  -- Step 2: Create a RECORD type for employee info
  TYPE EmployeeRec IS RECORD (
    emp_id NUMBER,
    emp_name VARCHAR2(50),
    attendance AttendanceArray
  );

  -- Step 3: Declare variables
  employee EmployeeRec;
  total_present NUMBER := 0;

BEGIN
  -- Step 4: Assign values (1 = Present, 0 = Absent)
  employee.emp_id := 101;
  employee.emp_name := 'Honette Igiraneza';
  employee.attendance := AttendanceArray(1, 1, 0, 1, 1, 0, 1);

  -- Step 5: Validate attendance data (must be 7 days)
  IF employee.attendance.COUNT < 7 THEN
    GOTO incomplete_data;
  END IF;

  -- Step 6: Calculate total number of present days
  FOR i IN 1..employee.attendance.COUNT LOOP
    IF employee.attendance(i) = 1 THEN
      total_present := total_present + 1;
    END IF;
  END LOOP;

  -- Step 7: Display results
  DBMS_OUTPUT.PUT_LINE('Employee Name: ' || employee.emp_name);
  DBMS_OUTPUT.PUT_LINE('Days Present: ' || total_present);
  DBMS_OUTPUT.PUT_LINE('Days Absent: ' || (7 - total_present));

  GOTO end_program;

  -- Step 8: Label for missing or incomplete data
  <<incomplete_data>>
  DBMS_OUTPUT.PUT_LINE('Error: Attendance data incomplete for ' || employee.emp_name);

  -- Step 9: End program
  <<end_program>>
  DBMS_OUTPUT.PUT_LINE('Attendance check completed.');

END;
/
# Expected output
<img width="604" height="350" alt="image" src="https://github.com/user-attachments/assets/ed8c34cf-ee99-45cc-a51c-256989672c16" />
Incomplete data entry
<img width="818" height="152" alt="image" src="https://github.com/user-attachments/assets/bd71a3f0-03df-4fb0-9bb2-4ecbb8f9bb3a" />
# Explanation
| Concept                 | How it’s Used                                          |
| ----------------------- | ------------------------------------------------------ |
| **Collection (VARRAY)** | Stores 7 attendance records for each day of the week   |
| **Record**              | Groups employee ID, name, and attendance data together |
| **GOTO**                | Skips calculation if attendance data is incomplete     |
# Conclusion

This project demonstrates how PL/SQL composite data types (collections and records) and flow control (GOTO) can be used together to build a simple real-world system.


