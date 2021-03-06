import React, { Component } from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import SignoutLink from './signout_link';
import NewMessageButtonContainer from '../containers/new_message_button_container';
import MessageThreadlistRowContainer from '../containers/message_threadlist_row_container';
import NewMessageThreadlistRowContainer from '../containers/new_message_threadlist_row_container';

class MainSidebar extends Component {
  render() {
    const {
      messageThreads, activeThreadId, isAddingNewThread, newMessageThreadUsers,
      isNewThreadActive,
    } = this.props;

    return (
      <div className="main-sidebar__root">
        <header className="main-sidebar__header">
          <button className="main-sidebar__signout-button">
            <SignoutLink />
          </button>
          <div>
            <strong className="main-sidebar__header-title">Messenger</strong>
          </div>
          <NewMessageButtonContainer />
        </header>
        <div className="message-threadlist__root">
          <ul className="message-threadlist__rows-container">
            {isAddingNewThread && (
              <NewMessageThreadlistRowContainer
                users={newMessageThreadUsers}
                isActive={isNewThreadActive}
              />
            )}
            {messageThreads.map(mt => {
              const lastMessageSeenUserIds = mt.lastSeenMessageIdsByUserId.filter(item => {
                return _.isObject(mt.lastMessage) && item.lastSeenMessageId == mt.lastMessage.id;
              }).map(item => item.userId);
              return (
                <MessageThreadlistRowContainer
                  key={mt.id}
                  isActive={mt.id === activeThreadId}
                  messageThreadId={mt.id}
                  usernames={mt.receivers.map(r => r.username)}
                  lastMessage={mt.lastMessage}
                  lastMessageSeenUserIds={lastMessageSeenUserIds}
                  receivers={mt.receivers}
                />
              );
            })}
          </ul>
        </div>
      </div>
    );
  }
}

MainSidebar.propTypes = {
  isAddingNewThread: PropTypes.bool.isRequired,
  isNewThreadActive: PropTypes.bool.isRequired,
  newMessageThreadUsers: PropTypes.array.isRequired,
  messageThreads: PropTypes.array.isRequired,
  activeThreadId: PropTypes.string,
};

export default MainSidebar;
