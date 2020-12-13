import React, { useEffect, useState } from 'react';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';
import IconButton from '@material-ui/core/IconButton';
import Icon from '@material-ui/core/Icon';
import MenuIcon from '@material-ui/icons/Menu';
import Box from '@material-ui/core/Box';
import Container from '@material-ui/core/Container';
import CircularProgress from '@material-ui/core/CircularProgress';

import './App.css';
import OracleCard from './OracleCard';
import NewOracleCard from './NewOracleCard';

const knownOracles = [
  {
    "address": "3QVUnXdCq7vMJDjfcuM7G5qCqFKeBQuac8P",
    "publicKey": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAECSjyPMNqA5E8XnztmvdDhUboKQaq9wgUv8rWAgfFYR9Sh9UF5/ss4ClgJUCG1mKH8aTO/qZVnYyY8J2BOO4pAA=="
  },
  {
    "address": "3Qbur18V2vQfJEcnkqM3H9ieNozVup4mG2v",
    "publicKey": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAEeJEbcJ7fMx9UZZeVRYeF8YOZB3ZOLK2SooCj28SVcasX7QwImeqlk7Sc+n8k2PCXDDiqll2L0aQ7MBQ3ux3k+A=="
  },
  {
    "address": "3QZdm3KxwX4GRdrdGLxeZ4xmEyrv5rEXCqF",
    "publicKey": "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAETqsbijXCcXeX67luiVT00HbGtNpiv0OUV8xtDCOdvFtIN2/7Yo7y2B3Qhl1f0OhNi8VdlUjcM165BhzLMVPBrg=="
  }
]

function App() {
  const [oracles, setOracles] = useState([])
  const [createLoaderVisible, setCreateLoaderVisible] = useState(false)
  const [createVisible, setCreateVisible] = useState(false)

  useEffect(() => {
    const fetchData = async () => {
      const result = await fetch('/api/oracles').then(res => res.json())
      result.reverse()
      setOracles(result)
    };

    fetchData();
  }, [])

  const confirm = async (template) => {
    setCreateVisible(false)
    setCreateLoaderVisible(true)
    await fetch('/api/oracles', {
      method: 'POST',
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: JSON.stringify({
        "oracles": knownOracles,
        "definition": {
          "contractName": template.name,
          "trigger": template.trigger,
          "signatures": template.signatures,
          "windowSize": 1,
          "dataSources": template.dataSources
        }
      })
    })
    const result = await fetch('/api/oracles').then(res => res.json())
    result.reverse()
    setOracles(result)
    setCreateLoaderVisible(false)
  }

  const deleteOracle = async (id) => {
    await fetch(`/api/oracles/${id}`, {
      method: 'DELETE'
    })

    const result = await fetch('/api/oracles').then(res => res.json())
    result.reverse()
    setOracles(result)
  }

  const testDataSource = async (dataSource) => {
    const text = await fetch('/api/datasource/test', {
      method: 'POST',
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(dataSource)
    }).then(res => res.text())
    return text
  }

  const toggleCreateVisible = () => {
    setCreateVisible(!createVisible)
  }

  return (
    <div className="App" style={{ flexGrow: 1 }}>
      <Container maxWidth="md">
        <AppBar position="static">
          <Toolbar>
            <IconButton edge="start" color="inherit" aria-label="menu" style={{ marginRight: 10 }}>
              <MenuIcon />
            </IconButton>
            <Typography variant="h6" style={{ flexGrow: 1 }}>
              EasyOracle
            </Typography>
          </Toolbar>
        </AppBar>
        <div style={{ 'textAlign': 'right' }}>
          <Box my={1}>
            <Button color="primary" variant="contained" onClick={toggleCreateVisible}><Icon>add_task</Icon>Создать</Button>
          </Box>
          {createVisible ? <Box my={1}>
            <NewOracleCard confirm={confirm} testDataSource={testDataSource} />
          </Box> : ''}
        </div>
        {createLoaderVisible && <div style={{ 'textAlign': 'center' }}>
          <CircularProgress />
        </div>}
        <Box my={1}>
          {oracles.map((oracle, index) =>
            <Box key={index} my={1}>
              <OracleCard oracle={oracle} deleteOracle={deleteOracle} />
            </Box>
          )}
        </Box>
      </Container>
    </div>
  );
}

export default App;
