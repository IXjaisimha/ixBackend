create table ev_grids (
    grid_id bigint primary key,
    power_available decimal(10,2),
    power_limit decimal(10,2),
    energy_source varchar(50),
    city varchar(100)
);

create table cities (
    city_id bigint primary key,
    city_name varchar(100),
    costperkwh decimal(10,2)
);

create table owners (
    owner_id bigint primary key,
    govt_id bigint unique,
    first_name varchar(100),
    last_name varchar(100),
    address varchar(255)
);

create table ev_hubs (
    hub_id bigint primary key,
    grid_id bigint not null,
    no_of_charging_ports int,
    default_speed varchar(50),
    power_storage decimal(10,2),
    area varchar(100),
    safety_limit decimal(10,2),
    constraint fk_hubs_grids
        foreign key (grid_id) references ev_grids(grid_id)
);

create table ev_charging_ports (
    port_id bigint primary key,
    hub_id bigint not null,
    current_speed varchar(50),
    constraint fk_ports_hubs
        foreign key (hub_id) references ev_hubs(hub_id)
);

create table vehicles (
    vehicle_id bigint primary key,
    owner_id bigint not null,
    car_brand varchar(100),
    model_name varchar(100),
    battery_capacity int not null,
    registration_number varchar(50) not null unique,
    constraint fk_vehicles_owners
        foreign key (owner_id) references owners(owner_id)
);

create table subscriptions (
    subscription_id bigint primary key,
    owner_id bigint not null,
    start_date date,
    expiry_date date,
    type varchar(50),
    amount int,
    constraint fk_subscriptions_owners
        foreign key (owner_id) references owners(owner_id)
);

create table charging_plan (
    plan_id bigint primary key,
    city_id bigint not null,
    speed varchar(20),
    peak_hour_cost decimal(10,2),
    normal_hour_cost decimal(10,2),
    constraint fk_plan_cities
        foreign key (city_id) references cities(city_id)
);

create table charging_sessions (
    session_id bigint primary key,
    port_id bigint not null,
    vehicle_id bigint not null,
    plan_id bigint not null,
    energy_consumed decimal(10,2),
    time_consumed_hours_mins int,
    cost decimal(10,2),
    battery_level_before int,
    battery_level_after int,
    status varchar(50),
    constraint fk_sessions_ports
        foreign key (port_id) references ev_charging_ports(port_id),
    constraint fk_sessions_vehicles
        foreign key (vehicle_id) references vehicles(vehicle_id),
    constraint fk_sessions_plan
        foreign key (plan_id) references charging_plan(plan_id)
);

create table charging_logs (
    log_id bigint primary key,
    session_id bigint not null,
    time_of_entry datetime2,
    time_of_exit datetime2,
    constraint fk_logs_sessions
        foreign key (session_id) references charging_sessions(session_id)
);

create table registration (
    reg_id bigint primary key,
    plan_id bigint not null,
    port_id bigint not null,
    vehicle_id bigint not null,
    owner_id bigint not null,
    city_id bigint not null,
    start_time_slot time,
    constraint fk_reg_plan
        foreign key (plan_id) references charging_plan(plan_id),
    constraint fk_reg_port
        foreign key (port_id) references ev_charging_ports(port_id),
    constraint fk_reg_vehicle
        foreign key (vehicle_id) references vehicles(vehicle_id),
    constraint fk_reg_owner
        foreign key (owner_id) references owners(owner_id),
    constraint fk_reg_city
        foreign key (city_id) references cities(city_id)
);

create table payments (
    payment_id bigint primary key,
    owner_id bigint not null,
    session_id bigint not null,
    price decimal(10,2),
    payment_method varchar(50),
    payment_status varchar(50),
    constraint fk_payments_owner
        foreign key (owner_id) references owners(owner_id),
    constraint fk_payments_session
        foreign key (session_id) references charging_sessions(session_id)
);

create table loadbalancingtable (
    log_id bigint primary key,
    [timestamp] datetime2,
    hub_id bigint not null,
    available_capacity_for_ev_hub decimal(10,2),
    no_of_connected_ports int,
    non_ev_load decimal(10,2),
    ev_load decimal(10,2),
    ev_power_for_each_connected_port decimal(10,2),
    is_it_a_peak_hour bit,
    is_it_a_threshold bit,
    constraint fk_load_hub
        foreign key (hub_id) references ev_hubs(hub_id)
);

insert into ev_grids values
(1, 8000.00, 10000.00, 'solar', 'hyderabad'),
(2, 6000.00, 9000.00, 'wind', 'bangalore');

insert into cities values
(1, 'hyderabad', 12.50),
(2, 'bangalore', 13.20);

insert into owners values
(101, 900000001, 'ravi', 'kumar', 'madhapur, hyderabad'),
(102, 900000002, 'sneha', 'reddy', 'whitefield, bangalore'),
(103, 900000003, 'arjun', 'mehta', 'gachibowli, hyderabad');

insert into ev_hubs values
(201, 1, 10, 'fast', 3000.00, 'madhapur', 500.00),
(202, 2, 8, 'moderate', 2000.00, 'whitefield', 400.00);

insert into ev_charging_ports values
(301, 201, 'fast'),
(302, 201, 'moderate'),
(303, 202, 'fast'),
(304, 202, 'moderate');

insert into vehicles values
(401, 101, 'tata', 'nexon ev', 40, 'ts09ev1234'),
(402, 102, 'mg', 'zs ev', 50, 'ka01ev5678'),
(403, 103, 'hyundai', 'kona electric', 45, 'ts10ev9999');

insert into subscriptions values
(501, 101, '2026-01-01', '2026-12-31', 'premium', 7000),
(502, 102, '2026-02-01', '2026-08-01', 'basic', 2500),
(503, 103, '2026-01-15', '2026-12-31', 'premium', 6500);

insert into charging_plan values
(601, 1, 'fast', 15.00, 12.00),
(602, 2, 'moderate', 14.50, 11.50);

insert into charging_sessions values
(701, 301, 401, 601, 18.75, 90, 225.00, 20, 80, 'completed'),
(702, 302, 403, 601, 10.50, 45, 120.00, 40, 60, 'charging'),
(703, 303, 402, 602, 22.40, 110, 260.00, 30, 85, 'completed'),
(704, 304, 401, 602, -5.50, 30, -40.00, 80, 70, 'completed');

insert into charging_logs values
(801, 701, dateadd(hour,-3,getdate()), dateadd(hour,-1,getdate())),
(802, 702, dateadd(minute,-40,getdate()), null),
(803, 704, dateadd(day,-2,getdate()), dateadd(hour,1,dateadd(day,-2,getdate())));

insert into registration values
(901, 601, 301, 401, 101, 1, '09:30:00'),
(902, 601, 302, 403, 103, 1, '10:15:00'),
(903, 602, 303, 402, 102, 2, '11:45:00');

insert into payments values
(1001, 101, 701, 225.00, 'upi', 'success'),
(1002, 103, 702, 120.00, 'credit card', 'pending'),
(1003, 101, 704, -40.00, 'wallet', 'success');

insert into loadbalancingtable values
(1101, dateadd(minute,-30,getdate()), 201, 3000.00, 2, 2000.00, 1500.00, 750.00, 0, 0),
(1102, dateadd(minute,-20,getdate()), 202, 2500.00, 2, 2500.00, 2000.00, 1000.00, 1, 0),
(1103, dateadd(minute,-10,getdate()), 201, 1000.00, 5, 6000.00, 4500.00, 900.00, 1, 1);

select * from ev_grids;
select * from cities;
select * from owners;
select * from ev_hubs;
select * from ev_charging_ports;
select * from vehicles;
select * from subscriptions;
select * from charging_plan;
select * from charging_sessions;
select * from charging_logs;
select * from registration;
select * from payments;
select * from loadbalancingtable;

select distinct h.hub_id,
       g.power_limit,
       (l.ev_load + l.non_ev_load) as total_load
from ev_hubs h
join ev_grids g
    on g.grid_id = h.grid_id
join loadbalancingtable l
    on l.hub_id = h.hub_id
where (l.ev_load + l.non_ev_load) > g.power_limit;


select v.vehicle_id,
       v.registration_number,
       cs.session_id,
       p.current_speed as port_speed,
       cp.speed as plan_speed
from charging_sessions cs
join vehicles v
    on v.vehicle_id = cs.vehicle_id
join ev_charging_ports p
    on p.port_id = cs.port_id
join charging_plan cp
    on cp.plan_id = cs.plan_id
where lower(cs.status) = 'charging'
  and lower(p.current_speed) != lower(cp.speed);


select h.hub_id,
       sum(abs(cs.energy_consumed)) as energy_sent_to_grid
from charging_sessions cs
join ev_charging_ports p
    on p.port_id = cs.port_id
join ev_hubs h
    on h.hub_id = p.hub_id
join charging_logs cl
    on cl.session_id = cs.session_id
where cs.energy_consumed < 0
  and cl.time_of_entry >= dateadd(day, -7, getdate())
group by h.hub_id;


select distinct o.owner_id,
       o.first_name,
       cs.session_id,
       p.current_speed,
       cp.speed as expected_speed
from charging_sessions cs
join vehicles v
    on v.vehicle_id = cs.vehicle_id
join owners o
    on o.owner_id = v.owner_id
join subscriptions s
    on s.owner_id = o.owner_id
join ev_charging_ports p
    on p.port_id = cs.port_id
join ev_hubs h
    on h.hub_id = p.hub_id
join loadbalancingtable l
    on l.hub_id = h.hub_id
join charging_plan cp
    on cp.plan_id = cs.plan_id
where lower(s.type) = 'premium'
  and l.is_it_a_peak_hour = 1
  and lower(p.current_speed) <> lower(cp.speed);

select cs.session_id
from charging_sessions cs
left join charging_logs cl
    on cl.session_id = cs.session_id
where lower(cs.status) = 'completed'
  and cl.session_id is null;
