/** @jsx React.DOM */

function appearances_of_item_in_array(myitem, myarray) {
  var i;
  var count = 0;
  for (i = 0; i < myarray.length; ++i) {
    if (myitem == myarray[i]) {
      ++count;
    }
  } 
  return count;
}

var FeedbackMatrix = React.createClass({
  render: function() {

    // Generate matrix_data to output the feedback matrix
    var i, j;
    var members = this.props.data.members.sort();
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

    // create table data
    var table_data = new Array(members.length + 1);

    for (i = 0; i < members.length; ++i) {
      table_data[i] = new Array(members.length + 1);
      table_data[i][0] = members[i];

      for (j = 0; j < members.length; ++j) { 
        table_data[i][j+1] = appearances_of_item_in_array(members[j], matrix_data[members[i]]);
      }
    }

    return (
      <table>
        <thead>
          <tr>
            <th>&nbsp;</th>
            {members.map(function(cell) {
              return <th>{cell}</th>;
            })}
          </tr>
        </thead>
        <tbody>
          {table_data.map(function(row) {
            return (
              <tr>
                {row.map(function(cell) {
                  var td_class = "feedbackmatrix-n" + cell
                  return <td className={td_class}>{cell}</td>;
                })}
              </tr>);
          })}
        </tbody>
      </table>
    );
  }
});

function boardcalculate_points(member, members, feedback) {
  var i, j, points;
  points = 0;
  for (i = 0; i < feedback.length; ++i) {
    if (feedback[i][0] == member || feedback[i][1] == member) {
      ++points;
    } 
  }
  return points;
}

function sort_the_leader(board) {
  board = board.sort(function(a, b) {
    return parseInt(a[1]) >= parseInt(b[1]);
  });

  return board.reverse();
}

function add_percentage(board) {
  var i;
  var max = board[0][1];
  for (i = 0; i < board.length; ++i) {
    board[i].push(((board[i][1]*100)/max));
  }
  return board;
}

var LeaderBoard = React.createClass({
  render: function() {

    var members = this.props.data.members.sort();
    var feedback = this.props.data.feedback;

    var board = new Array(members.length);

    var i, j;
    for (i = 0; i < members.length; ++i) {
      board[i] = new Array(2);
      board[i][0] = members[i];
      board[i][1] = boardcalculate_points(members[i], members, feedback);
    }

    board = sort_the_leader(board);
    board = add_percentage(board);

    return (
      <div>
      {board.map(function(cell) {
        return (
          <div className="item">
            <div className="name">{cell[0]}</div>
            <div className="rightboard">
              <span className="points" >{cell[1]} points</span>
              <span className="bar" style={{ width: cell[2] +"%"}}>&nbsp;</span>
            </div>
          </div>
          );
      })}</div>
    );
  }
});


$.getJSON('./data.json', function(data) {

  React.renderComponent(
    <FeedbackMatrix data={data} />,
    document.getElementById('feedbackmatrix')
  );

  React.renderComponent(
    <LeaderBoard data={data} />,
    document.getElementById('leaderboard')
  );

});