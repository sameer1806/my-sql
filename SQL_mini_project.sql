-- question 1


select bidder_id, 
((sum(case
when bid_status = 'won' then 1 else 0
end))/(sum(case
when bid_status = 'won' or 'lost' then 1 else 1
end))*100) as 'winning_percentage'

from  ipl_bidding_details
group by bidder_id
order by ((sum(case
when bid_status = 'won' then 1 else 0
end))/(sum(case
when bid_status = 'won' or 'lost' then 1 else 1
end))*100) desc;


-- 2.	Which teams have got the highest and the lowest no. of bids?

create view max_bid as
SELECT bd.BID_TEAM, t.TEAM_NAME, count(bd.Bid_team) as no_of_bids
FROM ipl_bidding_details bd
inner join ipl_team t
on bd.BID_TEAM = t.TEAM_ID
group by bd.BID_TEAM
order by bd.bid_team desc
limit 1;

create view min_bid as
SELECT bd.BID_TEAM, t.TEAM_NAME, count(bd.Bid_team) as no_of_bids
FROM ipl_bidding_details bd
inner join ipl_team t
on bd.BID_TEAM = t.TEAM_ID
group by bd.BID_TEAM
order by bd.bid_team
limit 1;

select * from max_bid
union all
select * from min_bid;



-- question 3

select isch.stadium_id , ist.stadium_name, ist.city,

((sum(case
when im.toss_winner = im.match_winner then 1 
end ))/(sum(case
when im.toss_winner != im.match_winner or im.toss_winner = im.match_winner then 1 
end ))*100) as 'winning_percentage'

from ipl_match as im inner join ipl_match_schedule as isch
on im.match_id = isch.match_id
inner join ipl_stadium as ist
on isch.stadium_id = ist.stadium_id 
group by ist.stadium_name
order by
((sum(case
when im.toss_winner = im.match_winner then 1 
end ))/(sum(case
when im.toss_winner != im.match_winner or im.toss_winner = im.match_winner then 1 
end ))*100) desc ;

-- question 4

select bd.bid_team, t.TEAM_NAME, count(bd.bid_status) as no_of_bids
from ipl_bidding_details bd
inner join ipl_team t
on bd.BID_TEAM = t.TEAM_ID
where bd.BID_STATUS = "Won"
group by bd.bid_team
order by no_of_bids desc
limit 1;


-- question 5

create view ipl17 as 
select team_id, tournmt_id, total_points from ipl_team_standings 
where tournmt_id=2017;
 
create view ipl18 as 
select team_id, tournmt_id, total_points from ipl_team_standings 
where tournmt_id=2018;

select s1.team_id, it.team_name, s1.tournmt_id as 'Season1', s1.total_points as 'S1_points',
s2.tournmt_id as 'Season2', s2.total_points as 'S2_points' ,
((s2.total_points - s1.total_points)/s1.total_points)*100 as 'percentage_difference'
from ipl17 as s1 inner join ipl18 as s2
on s1.team_id = s2.team_id
inner join ipl_team as it
on s1.team_id = it.team_id
group by s1.team_id
order by percentage_difference desc limit 1;