# git-foreman
this is a git commit robot for testing git performance.

#### environment - tiny network by virtualbox

```
  +---[github/gitlab]:on internet
  |
[vyos]
  |             * master git server
  |       +----+[gst121]: 192.168.1.121
  |       |     [mygitprj.git] : master git repo
  |       |       stdby :'hooks/post-commit' or 'post-update' to mrr.
  |       |   
  |       |     * mirror git server
  |       +----+[gst130]: 192.168.1.130
  |       |     [mygitprj.git] : mirror git repo
  |       |   
[DNS]+----+
 dnsmasq  |
 (forward)|     * git foreman
          +----+[gst131]: 192.168.1.131
          |      [./mst/mygitprj] : clone from master repo.
          |
          |
          |     * git workman / factory girl / operator
          +----+[gst132]: 192.168.1.132
                 [./mrr/mygitprj] : clone from mirror repo.
```

#### the Cast of each shell

1. atgit_foreman.sh

 this shell was made for the git performance testing.  
 auto make a file for commit into git server, or modify a file at each 30 sec.(default)  
 in this shell, call [lipsum.sh] for making a file on fixed byte size.  
 
2. lipsum.sh

  this is the lorem ipsum by bash.

3. set_auth.sh

  this is setting for connecting by ssh with no passphrase.  
  (this is not good style. I will change more secure network.)
  
4. rm_key.sh

  for delete key from the authorized_keys file.  
  I don't want to open and search key name by my eyes.
  
