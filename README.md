# tournament
Simple app to track results and pairings in a Swiss-style tournament.
Uses a PostgreSQL database configured on a virtual machine provided by Udacity.

To run this app:
<ol>
  <li> Install <a href="https://www.virtualbox.org/wiki/Downloads">Virtual Box</a></li>
  <li> Install <a href="https://www.vagrantup.com/downloads.html">Vagrant</a></li>
  <li> Fork then clone to your local machine <a href="https://github.com/udacity/fullstack-nanodegree-vm">fullstack-nanodegree-vm repository</a></li>
  <li> cd to ~/FSND-Virtual-Machine/vagrant</li>
  <li> Run $ <code>vagrant up</code>
  <li> Once installed, run $ <code>vagrant ssh</code> to log into the virtual machine provided by Udacity</li>
  <li> From within the VM, cd into /vagrant/tournament</li>
  <li> Run $ <code> psql \i tournament.sql</code> to create tournament database</li>
  <li> Exit psql and (still within VM) run $<code>python tournament_test.py</code> to execute unit tests for app</li>
</ol>
