import React from "react";
import Table from 'react-bootstrap/Table';

const DataTable = ({ data = [] }) => {

  return (
    <Table striped bordered hover responsive="sm">
      {data && data.length > 0 && (
        <thead>
          <tr>
            { Object.keys(data[0]).map((row, index) => (<th key={index}>{row}</th>)) }
          </tr>
        </thead>
      )}
      {data && data.length > 0 && (
        <tbody>
          {data.map((row, index) => (
            <tr key={index}>
              { Object.values(row).map((cell, index) => (<td key={index}>{cell}</td>)) }
            </tr>
          ))}
        </tbody>
      )}
    </Table>
  );
};

export default DataTable;


