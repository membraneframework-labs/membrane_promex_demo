# MembranePromExDemo

1. Clone this repo [https://github.com/wende/membrane_promex_demo](https://github.com/wende/membrane_promex_demo.git) or follow [Setting Up Promex](https://hexdocs.pm/prom_ex/readme.html#setting-up-promex) yourself 
2. Run `fly launch`. Register if you don't have an account yet
3. Add to `fly.toml` in your project directory:   
```yaml
    [[metrics]]
    path = "/metrics"
    port = 8080  
```

4. Run `fly deploy`
5. Import dashboard into Grafana at https://fly-metrics.net 
<img width="169" alt="Screenshot 2025-02-27 at 17 55 53" src="https://github.com/user-attachments/assets/4729a68a-1bef-478f-9a42-bcbf8d954c07" />

6. Paste the json code from [membrane_promex/dashboard.json](https://github.com/membraneframework/membrane_promex/blob/master/dashboard.json) 

7. Profit
<img width="1396" alt="Screenshot 2025-02-17 at 15 56 37" src="https://github.com/user-attachments/assets/d942662f-9356-4410-bbc6-c5f48752d4c8" />
