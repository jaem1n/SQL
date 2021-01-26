SELECT s.*, v.total_views, v.total_unique_views
FROM (SELECT con.*, SUM(total_submissions) total_submission, SUM(total_accepted_submissions) total_accepted_submissions
      FROM Contests con
        INNER JOIN Colleges col ON con.contest_id = col.contest_id
        INNER JOIN Challenges ch ON col.college_id = ch.college_id
        INNER JOIN Submission_Stats ss ON ch.challenge_id = ss.challenge_id
      GROUP BY con.contest_id, hacker_id, name) s
    INNER JOIN (SELECT con.*, SUM(total_views) total_views, SUM(total_unique_views) total_unique_views
                FROM Contests con
                    INNER JOIN Colleges col ON con.contest_id = col.contest_id
                    INNER JOIN Challenges ch ON col.college_id = ch.college_id
                    INNER JOIN View_Stats vs ON ch.challenge_id = vs.challenge_id
                GROUP BY con.contest_id, hacker_id, name) v
    ON s.contest_id = v.contest_id
WHERE total_submission + total_accepted_submissions + total_views + total_unique_views != 0
ORDER BY contest_id
;