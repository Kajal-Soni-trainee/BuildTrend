create database BuildTrend;
use BuildTrend;

create table users (
u_id int primary key not null auto_increment,
u_name varchar(255),
u_email varchar(255),
u_contact bigint,
u_address text,
u_password varchar(255),
u_role boolean
);

create table properties(
property_id int not null auto_increment primary key,
property_name varchar(255) not null,
property_address varchar(255) not null ,
owner_id int not null,
foreign key (owner_id) references users(u_id) on delete cascade
);

create table jobs(
job_id int not null auto_increment primary key,
property_id int not null,
contractor_id int,
owner_id int not null,
foreign key (contractor_id) references users(u_id) on delete cascade,
foreign key (owner_id) references users(u_id) on delete cascade,
foreign key (property_id) references properties(property_id) on delete cascade
);

create table jobs_categories(
job_category_id int not null auto_increment primary key,
job_id int not null,
title varchar(255) not null,
description varchar(255) not null,
foreign key (job_id) references jobs (job_id) on delete cascade
);

create table job_category_images(
image_id int not null auto_increment primary key,
job_category_id int not null,
image varchar(255) not null,
foreign key (job_category_id) references jobs_categories(job_category_id)
);

create table estimates(
estimate_id int not null auto_increment primary key,
job_id int not null,
contractor_id int not null,
cost decimal not null,
foreign key (job_id) references jobs(job_id) on delete cascade,
foreign key (contractor_id) references users(u_id) on delete cascade
);

create table user_state(
user_state_id int not null auto_increment primary key,
job_id int not null,
state tinyint not null,
foreign key (job_id) references jobs(job_id) on delete cascade
);

create table contractor_state(
contractor_state_id int not null auto_increment primary key,
job_id int not null,
state tinyint not null,
foreign key (job_id) references jobs(job_id) on delete cascade
);

create table work_proofs(
work_proof_id int not null auto_increment primary key,
job_id int not null,
description varchar(255),
foreign key(job_id) references jobs (job_id) on delete cascade
);

create table work_proof_images(
work_image_id int not null auto_increment primary key,
work_proof_id int not null,
image varchar(255) not null,
foreign key (work_proof_id) references work_proofs(work_proof_id) on delete cascade
);

create table comments(
comment_id int not null auto_increment primary key,
work_proof_id int not null,
comment varchar(255) not null,
foreign key(work_proof_id) references work_proofs(work_proof_id) on delete cascade
);

