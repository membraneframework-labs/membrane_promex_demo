# MembranePromexDemo



1. Pull https://github.com/wende/membrane_promex_demo
2. Run `fly launch`. Register if you don't yet have an account
3. Add to `fly.toml` in your project directory:   
```yaml
    [[metrics]]
    path = "/metrics"
    port = 8080  
```

4. Run `fly deploy`
5. Import dashboard into Grafana at https://fly-metrics.net 
<img width="169" alt="Screenshot 2025-02-27 at 17 55 53" src="https://github.com/user-attachments/assets/4729a68a-1bef-478f-9a42-bcbf8d954c07" />

6. Paste the json code below

7. Profit
<img width="1396" alt="Screenshot 2025-02-17 at 15 56 37" src="https://github.com/user-attachments/assets/d942662f-9356-4410-bbc6-c5f48752d4c8" />



   
```json
{
    "annotations": {
        "list": [
            {
                "builtIn": 1,
                "datasource": {
                    "type": "grafana",
                    "uid": "-- Grafana --"
                },
                "enable": true,
                "hide": true,
                "iconColor": "rgba(0, 211, 255, 1)",
                "name": "Annotations & Alerts",
                "type": "dashboard"
            }
        ]
    },
    "editable": true,
    "fiscalYearStartMonth": 0,
    "graphTooltip": 0,
    "id": 354867,
    "links": [],
    "panels": [
        {
            "datasource": {
                "default": true,
                "type": "prometheus",
                "uid": "prometheus_on_fly"
            },
            "description": "",
            "gridPos": {
                "h": 19,
                "w": 23,
                "x": 0,
                "y": 0
            },
            "id": 1,
            "pluginVersion": "11.2.2",
            "targets": [
                {
                    "datasource": {
                        "type": "prometheus",
                        "uid": "prometheus_on_fly"
                    },
                    "disableTextWrap": false,
                    "editorMode": "code",
                    "exemplar": false,
                    "expr": "{__name__=~\"membrane_.*_duration\", traceID=~\"$trace\"}",
                    "format": "time_series",
                    "fullMetaSearch": false,
                    "includeNullMetadata": true,
                    "instant": false,
                    "interval": "",
                    "legendFormat": "__auto",
                    "range": true,
                    "refId": "A",
                    "useBackend": false
                }
            ],
            "title": "Membrane Telemetry",
            "transformations": [
                {
                    "id": "reduce",
                    "options": {
                        "labelsToFields": true,
                        "reducers": [
                            "lastNotNull"
                        ]
                    }
                },
                {
                    "id": "calculateField",
                    "options": {
                        "alias": "duration",
                        "binary": {
                            "left": "Last *",
                            "operator": "*",
                            "right": "1"
                        },
                        "mode": "binary",
                        "reduce": {
                            "include": [
                                "Value"
                            ],
                            "reducer": "sum"
                        }
                    }
                },
                {
                    "disabled": true,
                    "id": "calculateField",
                    "options": {
                        "alias": "event.as",
                        "mode": "reduceRow",
                        "reduce": {
                            "reducer": "sum"
                        }
                    }
                }
            ],
            "type": "traces"
        }
    ],
    "refresh": "",
    "schemaVersion": 39,
    "tags": [],
    "templating": {
        "list": [
            {
                "current": {
                    "selected": true,
                    "text": "membrane-promex-demo",
                    "value": "membrane-promex-demo"
                },
                "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus_on_fly"
                },
                "definition": "label_values(membrane_pipeline_handle_init_stop_duration,app)",
                "hide": 0,
                "includeAll": false,
                "multi": false,
                "name": "app",
                "options": [],
                "query": {
                    "qryType": 1,
                    "query": "label_values(membrane_pipeline_handle_init_stop_duration,app)",
                    "refId": "PrometheusVariableQueryEditor-VariableQuery"
                },
                "refresh": 1,
                "regex": "",
                "skipUrlSync": false,
                "sort": 0,
                "type": "query"
            },
            {
                "allValue": ".*",
                "current": {
                    "selected": true,
                    "text": "All",
                    "value": "$__all"
                },
                "datasource": {
                    "type": "prometheus",
                    "uid": "prometheus_on_fly"
                },
                "definition": "label_values(traceID)",
                "hide": 0,
                "includeAll": true,
                "multi": false,
                "name": "trace",
                "options": [],
                "query": {
                    "qryType": 1,
                    "query": "label_values(traceID)",
                    "refId": "PrometheusVariableQueryEditor-VariableQuery"
                },
                "refresh": 2,
                "regex": "",
                "skipUrlSync": false,
                "sort": 0,
                "type": "query"
            }
        ]
    },
    "time": {
        "from": "now-5m",
        "to": "now"
    },
    "timepicker": {},
    "timezone": "browser",
    "title": "Membrane",
    "uid": "cecyjmdhgz6kgf",
    "version": 27,
    "weekStart": ""
}
```


