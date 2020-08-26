FROM elastic/rally:2.0.1

# Rally runs as user 1000 and its files are installed with uid:gid 1000:0
COPY --chown=1000:0 rally.ini /rally/.rally/

