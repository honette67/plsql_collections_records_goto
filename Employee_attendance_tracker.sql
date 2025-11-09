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
  employee.attendance := AttendanceArray( 1, 0, 1, 1, 0, 1);

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