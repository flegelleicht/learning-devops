# learning-devops

## Exploring Zero-Downtime Deployments

1. Start traefik as load balancer

		learning-devops $ docker-compose -d -f traefik.yml up

2. Build and start `master`

		learning-devops $ docker-compose -f master.yml build
		
		learning-devops $ cat > master.yml <<EOF
		version: '3'
		services:
			master:
				build: ./service
				expose:
					- "4567"
				labels:
					- "traefik.frontend.rule=Host:service.localhost"
		EOF
		
		learning-devops $ docker-compose -d -f master.yml up

	Note the `Host`, this is what traefik will load balance for us. We will have all future versions of our project run under the same host to help with zero-downtime deployment, hopefully.

3. Use `master`
		
		learning-devops $ curl -H 'Host: service.localhost' localhost
		{"status":"ok","message":"Success"}
		
3. Develop, branch, commit etc.

		learning-devops $ git checkout -b branch
		learning-devops $ export BRANCH=branch

4. Create new `yml` for your branch

		learning-devops $ cat > $BRANCH.yml <<EOF
		version: '3'
		services:
			$BRANCH:
				build: ./service
				expose:
					- "4567"
				labels:
					- "traefik.frontend.rule=Host:service.localhost"
		EOF

4. Build new image

		learning-devops $ docker-compose -f $BRANCH.yml build

5. Start new branch image

		docker-compose -f $BRANCH.yml up

6. Stop older image

		docker-compose -f master.yml stop master
