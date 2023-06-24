ignore the modules for now


**To bootstrap on 23.05**


```
nix run home-manager/release-23.05 -- init --switch

```



else



init flake home-manager in ~/.config/home-manager



write basic *home.nix*



```
nix run ~/.config/nixpkgs#homeConfigurations.$YourUserName.activationPackage
```



**encrypt secrets with sops-nix and nix run**




```
# credits 
# bwolf @sr.ht
mkdir -p .config/sops/age
# Remove passphrase from key.
cp ~/.ssh/id_ed25519 tmp-key
chmod 0600 tmp-key
ssh-keygen -p -N "" -f tmp-key
nix run nixpkgs#ssh-to-age -- -private-key \
    -i ~/tmp-key >.config/sops/age/keys.txt
# Protect private key.
chmod 0600 .config/sops/age/keys.txt

nix-shell -p age --run "age-keygen -y ~/.config/sops/age/keys.txt" >> .sops.yaml (format)
#decrypt
ssh-keyscan -t ed25519 host | nix run nixpkgs#ssh-to-age

#encrypt any file to put in system

nix run nixpkgs#sops -- secrets/example.yaml
cat secrets/example.yaml

#refer secrets in config (todo)

sops.defaultSopsFile = ./../example.yaml;
sops.secrets.example-key = {};
sops.secrets."myservice/my_subdir/my_secret" = {};
```





