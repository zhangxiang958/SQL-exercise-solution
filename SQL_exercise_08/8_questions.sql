-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.
SELECT name
FROM physicians
WHERE employeeID IN(
SELECT physician
FROM Undergoes LEFT JOIN Trained_In
ON Undergoes.physician = Trained_In.physician AND Trained_In.procedure IS NULL);
-- 8.2 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.
SELECT physicians.name, procedure.name, data.Date, patient.name
FROM 
(SELECT physician, Date, procedure, patient
FROM Undergoes LEFT JOIN Trained_In ON Trained_In.Treatment IS NULL) data, physicians, patients, procedure
WHERE data.physician = physicians.employeeID AND data.patient = patients.SSN AND procedure.code = data.procedure;
-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).
SELECT physicians.name
FROM physicians, Trained_In, Undergoes
WHERE Trained_In.physician = physicians.employeeID AND Trained_In.Treatment = Undergoes.procedure AND Undergoes.date > Trained_In.CertificationExpires
AND physicians.employeeID = Undergoes.physician;

-- 8.4 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.
SELECT physicians.name, procedure.name, Undergoes.date, Trained_In.CertificationExpires
FROM physicians, Trained_In, Undergoes, procedure
WHERE Trained_In.physician = physicians.employeeID AND Trained_In.Treatment = Undergoes.procedure AND Undergoes.date > Trained_In.CertificationExpires
AND physicians.employeeID = Undergoes.physician AND Trained_In.procedure = procedure.code;

-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.
SELECT patients.name, p1.name
FROM patients, physicians p1, physicians p2, appointments LEFT JOIN nurse ON appointments.prepNurse = nurse.employeeID
WHERE appointments.patients.SSN AND appointments.physician = physicians.employeeID AND patients.pcp = physicians.employeeID AND appointments.physician <> patients.PCP;

-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.
SELECT * FROM Undergoes U
 WHERE Patient <> 
   (
     SELECT Patient FROM Stay S
      WHERE U.Stay = S.StayID
   );
-- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.
SELECT N.Name FROM Nurse N
 WHERE EmployeeID IN
   (
     SELECT OC.Nurse FROM On_Call OC, Room R
      WHERE OC.BlockFloor = R.BlockFloor
        AND OC.BlockCode = R.BlockCode
        AND R.Number = 123
   );
-- 8.8 The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.
SELECT ExaminationRoom, COUNT(AppointmentID) AS Number FROM Appointment
GROUP BY ExaminationRoom;
-- 8.9 Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
    -- The patient has been prescribed some medication by his/her primary care physician.
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.
SELECT Pt.Name, PhPCP.Name FROM Patient Pt, Physician PhPCP
 WHERE Pt.PCP = PhPCP.EmployeeID
   AND EXISTS
       (
         SELECT * FROM Prescribes Pr
          WHERE Pr.Patient = Pt.SSN
            AND Pr.Physician = Pt.PCP
       )
   AND EXISTS
       (
         SELECT * FROM Undergoes U, Procedure Pr
          WHERE U.Procedure = Pr.Code
            AND U.Patient = Pt.SSN
            AND Pr.Cost > 5000
       )
   AND 2 <=
       (
         SELECT COUNT(A.AppointmentID) FROM Appointment A, Nurse N
          WHERE A.PrepNurse = N.EmployeeID
            AND N.Registered = 1
       )
   AND NOT Pt.PCP IN
       (
          SELECT Head FROM Department
       );