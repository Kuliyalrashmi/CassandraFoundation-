# pip install cassandra-driver

from cassandra.cluster import Cluster
cluster = Cluster(protocol_version = 3)
session = cluster.connect('killrvideo')


# Now write code to retrieve all records in the videos_by_tag table. Display your results using Python's print() function:
rows = session.execute(""" Select * from videos_by_tag """)

for row in rows : 
    print(f"tag : {row.tag} | Video ID : {row.video_id}  |  Added Date : {row.added_date} | Title : {row.title}")


#  Write some Python code to insert a new video into the database:
session.execute(""" Insert into videos_by_tag values ('datastax',uuid(), toTimeStamp('2024-12-14'),'Self added queery/Custom queery insert')""")


# Now write Python code to delete your record:
tag_value = 'datastax'
video_id_value = '1645ea59-14bd-11e5-a993-8138324b7e80'
session.execute(f""" delete from videos_by_tag where tag = '{tag_value}'  and video_id = {video_id_value} """)