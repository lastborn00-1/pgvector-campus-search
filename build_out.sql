create extension if not exists vector;
drop table if exists campus_notices;
create table campus_notices (
  id bigint generated always as identity primary key,
  title text not null,
  category text not null,
  source text not null,
  posted_at timestamptz not null default now(),
  content text not null,
  embedding vector(8) not null
);
insert into campus_notices (title, category, source, posted_at, content, embedding) values
('Weekly dining hall menu', 'dining', 'kwcht.edu.ng/menu', '2026-10-12 13:29:51+00'::timestamptz, 'The campus dining hall posted this week lunch menu with jollof rice and beans specials.', '[0.510118,0.225075,0.0,0.510118,0.100466,0.551394,0.0,0.33878]'::vector),
('Dinner service hours change', 'dining', 'kwcht.edu.ng/menu', '2026-10-04 13:29:51+00'::timestamptz, 'Dining hall dinner service now closes 8pm instead of 9pm from next week.', '[0.209077,0.59139,0.160293,0.354436,0.544596,0.376339,0.130424,0.0]'::vector),
('Library opening hours', 'library', 'kwcht.edu.ng/library', '2026-10-11 13:29:51+00'::timestamptz, 'The main library is open 8am to 10pm weekdays and 10am to 6pm weekends.', '[0.556516,0.531624,0.0,0.0,0.403607,0.417831,0.264923,0.0]'::vector),
('Library exam week 24 hour access', 'library', 'kwcht.edu.ng/library', '2026-10-10 13:29:51+00'::timestamptz, 'During exam week the library reading room stays open 24 hours for students.', '[0.253622,0.092876,0.215221,0.544751,0.730503,0.113415,0.100913,0.165212]'::vector),
('Campus shuttle timetable', 'transport', 'kwcht.edu.ng/shuttle', '2026-10-09 13:29:51+00'::timestamptz, 'The shuttle bus leaves the main gate every 30 minutes to Offa town.', '[0.459178,0.282735,0.0,0.378397,0.300804,0.589916,0.357139,0.0]'::vector),
('Shuttle route change', 'transport', 'kwcht.edu.ng/shuttle', '2026-10-03 13:29:51+00'::timestamptz, 'The evening shuttle bus route now stops at the market junction.', '[0.432618,0.162757,0.0,0.185858,0.101854,0.179558,0.842136,0.0]'::vector),
('Final exam timetable', 'academics', 'kwcht.edu.ng/exams', '2026-10-08 13:29:51+00'::timestamptz, 'The final exam deadline timetable for all departments is now online.', '[0.157407,0.285301,0.0,0.349794,0.151942,0.210969,0.744405,0.386959]'::vector),
('Course registration deadline', 'academics', 'portal.kwcht.edu.ng', '2026-10-07 13:29:51+00'::timestamptz, 'Course registration closes Friday, late registration attracts a fee.', '[0.432859,0.31327,0.0,0.599243,0.473155,0.0,0.362666,0.0]'::vector),
('Tech club meetup', 'events', 'campus events calendar', '2026-10-12 13:29:51+00'::timestamptz, 'The developer club meets Thursday 4pm to build an AI chatbot project.', '[0.148233,0.443669,0.122498,0.163674,0.701018,0.0,0.467345,0.171909]'::vector),
('Career fair', 'events', 'campus events calendar', '2026-10-06 13:29:51+00'::timestamptz, 'The career fair holds next month with employers from Lagos and Abuja.', '[0.731957,0.0,0.0,0.497502,0.142007,0.41935,0.0,0.143913]'::vector),
('Rainfall advisory', 'weather', 'nimet.gov.ng', '2026-10-11 13:29:51+00'::timestamptz, 'Heavy rain expected this week, students should carry umbrellas.', '[0.188743,0.194136,0.0,0.128345,0.900574,0.314931,0.0,0.0]'::vector),
('Gym renovation notice', 'sports', 'kwcht.edu.ng/gym', '2026-10-01 13:29:51+00'::timestamptz, 'The gym is closed for renovation until the end of the month.', '[0.797627,0.107592,0.0,0.191389,0.147939,0.381744,0.293808,0.248289]'::vector);
select count(*) as rows_loaded from campus_notices;
