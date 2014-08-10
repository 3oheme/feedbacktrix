/** @jsx React.DOM */

function appearances_of_item_in_array(myitem, myarray) {
  console.log('appearances_of_item_in_array for:');
  console.log(myitem);
  console.log(myarray);
  var i;
  var count = 0;
  for (i = 0; i < myarray.length; ++i) {
    if (myitem == myarray[i]) {
      ++count;
    }
  } 
  console.log(count);
  return count;
}

var FeedbackMatrix = React.createClass({
  render: function() {

    // Generate matrix_data to output the feedback matrix
    var i, j;
    var members = this.props.data.members;
    var feedback = this.props.data.feedback;
    var matrix_data = {};

    for (i = 0; i < members.length; ++i) {
      matrix_data[members[i]] = [];

      for (j = 0; j < feedback.length; ++j) {
        if (feedback[j][0] == members[i]) {
          matrix_data[members[i]].push(feedback[j][1]);
        }
        if (feedback[j][1] == members[i]) {
          matrix_data[members[i]].push(feedback[j][0]);
        }
      }
    }

    console.log(matrix_data);

    // create table data
    var table_data = new Array(members.length + 1);

    for (i = 0; i < members.length; ++i) {
      table_data[i] = new Array(members.length + 1);
      table_data[i][0] = members[i];

      for (j = 1; j < members.length; ++j) { 
        table_data[i][j] = appearances_of_item_in_array(members[j], matrix_data[members[i]]);
      }
    }

    console.log(table_data);

    return (
      <div>cool...</div>
      // <table><tbody>
      //   {matrix_data.map(function(row) {
      //     return (
      //       <tr>
      //         {row.map(function(cell) {
      //           return <td>{cell}</td>;
      //         })}
      //       </tr>);
      //   })}
      // </tbody></table>
    );
  }
});


$.getJSON('./data.json', function(data) {

  React.renderComponent(
    <FeedbackMatrix data={data} />,
    document.getElementById('feedbackmatrix')
  );

});